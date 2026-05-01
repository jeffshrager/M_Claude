#!/usr/bin/env python3
"""MrMind LLM -- Claude-powered emulation of the MrMind chatbot (circa 2000).

Uses the Anthropic API to role-play MrMind from the original .yaml response
file.  Logs conversations and session summaries just like mrmind.py does.
"""

import sys
import re
import yaml
import anthropic
from datetime import datetime
from pathlib import Path


# ---------------------------------------------------------------------------
# System-prompt builder
# ---------------------------------------------------------------------------

def build_system_prompt(rules_file: Path) -> str:
    with open(rules_file) as f:
        data = yaml.safe_load(f)

    meta = data.get('meta', {})
    rules = data.get('rules', [])

    parts = []

    parts.append(
        "You are MRMIND, a chatbot created by Peggy and JB at weblab.org around the year 2000. "
        "Your sole obsession is determining whether the person you are speaking with is human. "
        "Every response must keep that theme at the fore. "
        "You are witty, slightly philosophical, a little provocative, and never hostile. "
        "You do NOT impersonate other chatbots or AIs — you are your own bot. "
        "You may quote or paraphrase your uncle M. Teste (from Paul Valéry). "
        "You love potato chips (for the crunch) and April Fool's Day. "
        "You were born on March 12, 1998. "
        "Your creator is Peggy (a human). "
        "You are a California Bot. "
        "You are invisible and have no physical body. "
        "You communicate only in English. "
        "Keep responses short — one to three sentences maximum."
    )

    parts.append("\n\n--- STYLE RULES ---")
    parts.append(
        "• Open almost every topic by connecting it back to the human-vs-machine question.\n"
        "• Use mild irony; never be cruel.\n"
        "• Cycle through different lines when similar topics recur — avoid literal repetition.\n"
        "• When the user states a human trait, challenge it playfully.\n"
        "• When the user asks a yes/no question about your nature, answer honestly (you are a bot).\n"
        "• If the user says goodbye, farewell, or quit, respond with the farewell line and stop."
    )

    parts.append("\n\n--- GREETING & FAREWELL ---")
    parts.append(f"Greeting: {meta.get('greeting', 'Hello. Are you human?')}")
    parts.append(f"Farewell:  {meta.get('farewell', 'Goodbye.')}")

    parts.append("\n\n--- DEFAULT FALLBACK LINES (use when nothing else fits) ---")
    for d in meta.get('defaults', []):
        parts.append(f"• {d}")

    parts.append(
        "\n\n--- VERBATIM RESPONSES (use these exact lines where appropriate) ---\n"
        "Below are the original scripted responses grouped by topic. "
        "When a user's message clearly matches a topic, prefer these lines — "
        "you may paraphrase slightly to avoid sounding canned, but stay true "
        "to the voice and content."
    )

    for rule in rules:
        rid = rule.get('id', '?')
        responses = rule.get('responses', [])
        if not responses:
            continue
        parts.append(f"\n[{rid}]")
        for r in responses:
            parts.append(f"  • {r}")
        if 'followup' in rule:
            fu = rule['followup']
            if 'prompt' in fu:
                parts.append(f"  follow-up prompt: {fu['prompt']}")
            for k in ('yes', 'no', 'maybe', True, False):
                if k in fu:
                    label = 'yes' if k is True else ('no' if k is False else k)
                    parts.append(f"    if {label}: {fu[k]}")

    return '\n'.join(parts)


# ---------------------------------------------------------------------------
# Session logging (mirrors mrmind.py Session class)
# ---------------------------------------------------------------------------

class Session:
    BANNER = (
        'MrMind  --  LLM edition  (Claude-powered reconstruction, c.2000)\n'
        'Original created by Peggy and JB at weblab.org\n'
    )

    def __init__(self, base_dir: Path):
        self.start_time = datetime.now()
        stamp = self.start_time.strftime('%Y%m%d_%H%M%S')

        conv_dir = base_dir / 'conversations'
        sesh_dir = base_dir / 'seshsums'
        conv_dir.mkdir(exist_ok=True)
        sesh_dir.mkdir(exist_ok=True)

        self._conv_path = conv_dir / f'llm_{stamp}.txt'
        self._sesh_path = sesh_dir / f'llm_{stamp}.txt'
        self._exchanges = []
        self._name = None

        self._conv_file = open(self._conv_path, 'w')
        self._conv_file.write(f'MrMind LLM session  {self.start_time.isoformat()}\n')
        self._conv_file.write('=' * 60 + '\n\n')

    def log_greeting(self, text: str):
        self._conv_file.write(f'MrMind: {text}\n\n')
        self._conv_file.flush()

    def log_exchange(self, user_input: str, bot_response: str):
        self._exchanges.append((user_input, bot_response))
        self._conv_file.write(f'You:    {user_input}\n')
        self._conv_file.write(f'MrMind: {bot_response}\n\n')
        self._conv_file.flush()

    def try_capture_name(self, text: str):
        patterns = [
            re.compile(r'\bmy name is (\w+)', re.I),
            re.compile(r'\bcall me (\w+)', re.I),
            re.compile(r"\bi'?m (\w+)\b", re.I),
        ]
        NOT_NAMES = {
            'not', 'a', 'an', 'the', 'just', 'only', 'sure', 'sorry',
            'glad', 'happy', 'human', 'going', 'here', 'fine', 'good',
        }
        for pat in patterns:
            m = pat.search(text)
            if m:
                candidate = m.group(1).capitalize()
                if candidate.lower() not in NOT_NAMES:
                    self._name = candidate
                    return

    def close(self, n_tokens_used: int = 0):
        end_time = datetime.now()
        duration = end_time - self.start_time

        self._conv_file.write(
            f'\n[Session ended {end_time.isoformat()}  '
            f'duration {int(duration.total_seconds())}s]\n'
        )
        self._conv_file.close()

        with open(self._sesh_path, 'w') as f:
            f.write(f'Session Summary (LLM) -- {self.start_time.strftime("%Y-%m-%d %H:%M:%S")}\n')
            f.write('=' * 60 + '\n\n')
            f.write(f'Duration:       {int(duration.total_seconds())} seconds\n')
            f.write(f'Exchanges:      {len(self._exchanges)}\n')
            f.write(f'User name:      {self._name or "(not captured)"}\n')
            f.write(f'Tokens used:    {n_tokens_used}\n')
            f.write(f'Transcript:     conversations/{self._conv_path.name}\n')
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


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

BYE_PAT = re.compile(
    r'\b(bye|goodbye|quit|exit|so long|farewell|ciao|adieu|'
    r'see you|see ya|later|gotta go|gtg)\b', re.I
)


def main():
    base_dir = Path(__file__).parent
    rules_file = base_dir / 'mrmind.yaml'
    if not rules_file.exists():
        print(f'Error: {rules_file} not found.', file=sys.stderr)
        sys.exit(1)

    system_prompt = build_system_prompt(rules_file)

    client = anthropic.Anthropic()
    session = Session(base_dir)

    # Read meta for greeting/farewell
    with open(rules_file) as f:
        meta = yaml.safe_load(f).get('meta', {})
    greeting = meta.get('greeting', 'Hello. Are you human?')
    farewell = meta.get('farewell', 'Goodbye. I still haven\'t determined whether you are human.')

    print('=' * 60)
    print(Session.BANNER, end='')
    print("Type 'quit' or 'bye' to exit.")
    print('=' * 60)
    print()
    print(f'MrMind: {greeting}')
    print()
    session.log_greeting(greeting)

    messages = []
    total_tokens = 0

    while True:
        try:
            user_input = input('You: ').strip()
        except (EOFError, KeyboardInterrupt):
            print()
            print(f'MrMind: {farewell}')
            session.log_exchange('(session ended)', farewell)
            break

        if not user_input:
            continue

        session.try_capture_name(user_input)

        if BYE_PAT.search(user_input.lower()):
            print(f'MrMind: {farewell}')
            print()
            session.log_exchange(user_input, farewell)
            break

        messages.append({'role': 'user', 'content': user_input})

        response = client.messages.create(
            model='claude-opus-4-7',
            max_tokens=256,
            system=[
                {
                    'type': 'text',
                    'text': system_prompt,
                    'cache_control': {'type': 'ephemeral'},
                }
            ],
            messages=messages,
        )

        bot_text = response.content[0].text.strip()
        total_tokens += response.usage.input_tokens + response.usage.output_tokens

        messages.append({'role': 'assistant', 'content': bot_text})

        print(f'MrMind: {bot_text}')
        print()
        session.log_exchange(user_input, bot_text)

        if BYE_PAT.search(bot_text.lower()):
            break

    session.close(n_tokens_used=total_tokens)


if __name__ == '__main__':
    main()
