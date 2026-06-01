#!/usr/bin/env python3
"""MrMind -- a reconstruction of the MrMind chatbot (circa 2000).

Original MrMind was created by Peggy and JB at weblab.org.
This is an ELIZA-style reconstruction based on the original .g source files.
"""

import argparse
import re
import yaml
import sys
from datetime import datetime
from pathlib import Path


class MrMind:

    YES_PAT = re.compile(
        r'\b(yes|yeah|yep|yah|sure|affirmative|right|correct|'
        r'i do|i am|i have|absolutely|definitely|of course|'
        r'indeed|certainly|true|aye|ok|okay|yup)\b', re.I
    )
    NO_PAT = re.compile(
        r"\b(no|nope|nah|never|not really|negative|"
        r"i don't|i can't|i won't|i haven't|i'm not|neither)\b", re.I
    )
    MAYBE_PAT = re.compile(
        r'\b(maybe|perhaps|not sure|dunno|possibly|'
        r"i don't know|hard to say|sometimes|sort of|"
        r'kind of|it depends|unsure)\b', re.I
    )

    NAME_PATS = [
        re.compile(r'\bmy name is (\w+)', re.I),
        re.compile(r'\bcall me (\w+)', re.I),
        re.compile(r'\bthis is (\w+)\b', re.I),
        re.compile(r"\bi'?m (\w+)\b", re.I),
    ]
    NOT_NAMES = {
        'not', 'a', 'an', 'the', 'just', 'only', 'sure', 'sorry',
        'glad', 'happy', 'human', 'going', 'trying', 'here', 'fine',
        'good', 'bad', 'tired', 'bored', 'curious', 'lost', 'confused',
        'frustrated', 'angry', 'sad', 'excited', 'ready', 'serious',
        'joking', 'kidding', 'done', 'thinking', 'wondering', 'looking',
        'talking', 'typing', 'asking', 'telling', 'saying', 'still',
        'already', 'always', 'never', 'sometimes', 'usually', 'actually',
        'really', 'very', 'so', 'too', 'also', 'even', 'back', 'there',
        'aware', 'alive', 'conscious', 'ok', 'okay', 'new', 'old',
        'right', 'wrong', 'afraid', 'able', 'trying', 'back', 'now',
        'here', 'there', 'not', 'no', 'yes',
    }

    BYE_PAT = re.compile(
        r'\b(bye|goodbye|quit|exit|so long|farewell|ciao|adieu|'
        r'see you|see ya|later|gotta go|gtg)\b', re.I
    )

    def __init__(self, rules_file):
        with open(rules_file) as f:
            data = yaml.safe_load(f)
        self.meta = data.get('meta', {})
        self.rules = sorted(data.get('rules', []), key=lambda r: -r.get('priority', 50))
        for rule in self.rules:
            rule['_compiled'] = [re.compile(p, re.I) for p in rule.get('patterns', [])]
            # YAML parses bare `yes` / `no` keys as True / False; remap to strings.
            if 'followup' in rule:
                rule['followup'] = {
                    ('yes' if k is True else 'no' if k is False else str(k).lower()): v
                    for k, v in rule['followup'].items()
                }
        self.name = None
        self.response_idx = {}
        self.followup = None
        self.focus = None           # current focused subject (str) or None
        self.last_rule_fired = None  # id of rule that handled the last turn
        self.last_focus_boosted = False  # True if focus caused the rule to win
        self.rules_fired = []   # ordered list of rule ids matched this session
        self.consecutive_defaults = 0
        self.topic_starter_idx = 0
        self.stall_threshold = self.meta.get('stall_threshold', 2)
        self.topic_starters = self.meta.get('topic_starters', [])

    def greet(self):
        return self.meta.get('greeting', 'Hello. Are you human?')

    def farewell(self):
        return self.meta.get('farewell', 'Goodbye.')

    def respond(self, user_input):
        text = user_input.strip()
        if not text:
            return '...'

        lower = text.lower()
        self._try_capture_name(lower)

        if self.BYE_PAT.search(lower):
            self.last_rule_fired = '__farewell__'
            self.last_focus_boosted = False
            return self.farewell()

        if self.followup:
            followup = self.followup
            self.followup = None
            response = self._handle_followup(lower, followup)
            if response:
                self.last_rule_fired = '__followup__'
                self.last_focus_boosted = False
                return self._personalize(response)

        rule = self._find_match(lower)
        if rule:
            self.rules_fired.append(rule['id'])
            self.last_rule_fired = rule['id']
            self.consecutive_defaults = 0
            response = self._next_response(rule)
            if 'followup' in rule:
                self.followup = rule['followup']
                prompt = rule['followup'].get('prompt', '')
                if prompt:
                    response = response + '  ' + prompt
            if 'focus' in rule:
                self.focus = rule['focus']
            elif rule.get('clear_focus'):
                self.focus = None
            return self._personalize(response)

        self.rules_fired.append('__default__')
        self.consecutive_defaults += 1

        # After stall_threshold consecutive defaults, proactively introduce a topic.
        if self.topic_starters and self.consecutive_defaults >= self.stall_threshold:
            self.consecutive_defaults = 0
            starter = self.topic_starters[self.topic_starter_idx % len(self.topic_starters)]
            self.topic_starter_idx += 1
            self.last_rule_fired = '__topic_starter__'
            return self._personalize(starter)

        defaults = self.meta.get('defaults', [
            'Tell me something human about yourself.',
            'Interesting. Are you human?',
            'What makes you say that?',
            "I'm not sure I follow. Are you human?",
            'Go on.',
            'Could you elaborate?',
            'I see. Does that make you human?',
            'Hmmm. Tell me more.',
        ])
        idx = self.response_idx.get('__default__', 0)
        response = defaults[idx % len(defaults)]
        self.response_idx['__default__'] = idx + 1
        self.last_rule_fired = '__default__'
        return self._personalize(response)

    # ------------------------------------------------------------------

    def _find_match(self, lower):
        # First pass: rules whose subjects include the current focus get priority.
        if self.focus:
            for rule in self.rules:
                if self.focus in rule.get('subjects', []) and self._matches(rule, lower):
                    self.last_focus_boosted = True
                    return rule
        # Second pass: all rules in normal priority order.
        self.last_focus_boosted = False
        for rule in self.rules:
            if self._matches(rule, lower):
                return rule
        return None

    def _matches(self, rule, lower):
        keywords = [str(k) for k in rule.get('keywords', [])]
        if keywords and not any(k in lower for k in keywords):
            return False
        compiled = rule.get('_compiled', [])
        if not compiled:
            return bool(keywords)
        return any(p.search(lower) for p in compiled)

    def _next_response(self, rule):
        rid = rule['id']
        responses = rule['responses']
        idx = self.response_idx.get(rid, 0)
        response = responses[idx % len(responses)]
        self.response_idx[rid] = idx + 1
        return response

    def _handle_followup(self, lower, followup):
        if self.YES_PAT.search(lower):
            return followup.get('yes')
        if self.NO_PAT.search(lower):
            return followup.get('no')
        if self.MAYBE_PAT.search(lower):
            return followup.get('maybe') or followup.get('no')
        return None

    def _try_capture_name(self, lower):
        for pat in self.NAME_PATS:
            m = pat.search(lower)
            if m:
                candidate = m.group(1).capitalize()
                if candidate.lower() not in self.NOT_NAMES:
                    self.name = candidate
                    return

    def _personalize(self, text):
        name = self.name or ''
        result = text.replace('[name]', name).replace('[NAME]', name.upper())
        if not name:
            result = re.sub(r',\s*\.', '.', result)
            result = result.replace(', .', '.').replace('  .', '.').strip()
        return result.strip()


# ----------------------------------------------------------------------

class Session:
    """Manages per-session transcript and summary logging."""

    BANNER = (
        'MrMind  --  a reconstruction of the MrMind chatbot (c.2000)\n'
        'Original created by Peggy and JB at weblab.org\n'
    )

    def __init__(self, base_dir: Path):
        self.start_time = datetime.now()
        stamp = self.start_time.strftime('%Y%m%d_%H%M%S')

        conv_dir = base_dir / 'conversations'
        sesh_dir = base_dir / 'seshsums'
        conv_dir.mkdir(exist_ok=True)
        sesh_dir.mkdir(exist_ok=True)

        self._conv_path = conv_dir / f'{stamp}.txt'
        self._sesh_path = sesh_dir / f'{stamp}.txt'
        self._exchanges = []   # list of (user, bot) pairs

        self._conv_file = open(self._conv_path, 'w')
        self._conv_file.write(f'MrMind session  {self.start_time.isoformat()}\n')
        self._conv_file.write('=' * 60 + '\n\n')

    def log_greeting(self, text: str):
        self._conv_file.write(f'MrMind: {text}\n\n')
        self._conv_file.flush()

    def log_exchange(self, user_input: str, bot_response: str, note: str = ''):
        self._exchanges.append((user_input, bot_response))
        self._conv_file.write(f'You:    {user_input}\n')
        self._conv_file.write(f'MrMind: {bot_response}\n')
        if note:
            self._conv_file.write(f'  {note}\n')
        self._conv_file.write('\n')
        self._conv_file.flush()

    def close(self, bot: MrMind):
        end_time = datetime.now()
        duration = end_time - self.start_time

        self._conv_file.write(
            f'\n[Session ended {end_time.isoformat()}  '
            f'duration {int(duration.total_seconds())}s]\n'
        )
        self._conv_file.close()

        # Unique rules fired (preserving first-occurrence order)
        seen = set()
        unique_rules = [r for r in bot.rules_fired if not (r in seen or seen.add(r))]

        with open(self._sesh_path, 'w') as f:
            f.write(f'Session Summary -- {self.start_time.strftime("%Y-%m-%d %H:%M:%S")}\n')
            f.write('=' * 60 + '\n\n')
            f.write(f'Duration:       {int(duration.total_seconds())} seconds\n')
            f.write(f'Exchanges:      {len(self._exchanges)}\n')
            f.write(f'User name:      {bot.name or "(not captured)"}\n')
            f.write(f'Transcript:     conversations/{self._conv_path.name}\n')
            f.write('\n')
            f.write(f'Rules fired ({len(unique_rules)} unique):\n')
            for r in unique_rules:
                f.write(f'  {r}\n')
            f.write('\n')
            if self._exchanges:
                f.write('First exchange:\n')
                u, b = self._exchanges[0]
                f.write(f'  You:    {u}\n')
                f.write(f'  MrMind: {b}\n')
            if len(self._exchanges) > 1:
                f.write('\nLast exchange:\n')
                u, b = self._exchanges[-1]
                f.write(f'  You:    {u}\n')
                f.write(f'  MrMind: {b}\n')


# ----------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description='MrMind chatbot')
    parser.add_argument('-v', '--verbose', action='store_true',
                        help='Print focus and rule id after each response')
    args = parser.parse_args()

    base_dir = Path(__file__).parent
    rules_file = base_dir / 'mrmind.yaml'
    if not rules_file.exists():
        print(f'Error: {rules_file} not found.', file=sys.stderr)
        sys.exit(1)

    bot = MrMind(rules_file)
    session = Session(base_dir)

    print('=' * 60)
    print(Session.BANNER, end='')
    print("Type 'quit' or 'bye' to exit.")
    print('=' * 60)
    print()

    greeting = bot.greet()
    print(f'MrMind: {greeting}')
    print()
    session.log_greeting(greeting)

    while True:
        try:
            user_input = input('You: ').strip()
        except (EOFError, KeyboardInterrupt):
            print()
            farewell = bot.farewell()
            print(f'MrMind: {farewell}')
            session.log_exchange('(session ended)', farewell)
            break

        if not user_input:
            continue

        response = bot.respond(user_input)
        print(f'MrMind: {response}')
        note = ''
        if args.verbose:
            rule_str = bot.last_rule_fired
            if bot.last_focus_boosted:
                rule_str += ' (*focus boosted*)'
            focus_str = bot.focus or 'none'
            followup_str = ''
            if bot.followup:
                prompt = bot.followup.get('prompt', '(no prompt)')
                followup_str = f' | followup: "{prompt}"'
            defaults_str = ''
            if bot.consecutive_defaults:
                defaults_str = f' | stall: {bot.consecutive_defaults}/{bot.stall_threshold}'
            note = f'[rule: {rule_str} | focus: {focus_str}{followup_str}{defaults_str}]'
            print(f'  {note}')
        print()
        session.log_exchange(user_input, response, note=note)

        if bot.BYE_PAT.search(user_input.lower()):
            break

    session.close(bot)


if __name__ == '__main__':
    main()
