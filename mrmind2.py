#!/usr/bin/env python3
"""MrMind 2 -- a modern Claude-native reconstruction of the MrMind chatbot.

Unlike mrmind_llm.py (which feeds the original 2000-era yaml script to Claude
as verbatim responses), this version gives Claude no script at all. Character,
mission, and style are established in the system prompt; Claude reasons freely
about what to probe next based on the actual conversation.
"""

import argparse
import csv
import re
import sys
import anthropic
from datetime import datetime
from pathlib import Path


# ---------------------------------------------------------------------------
# Multi-user identity / memory
# ---------------------------------------------------------------------------

MM2_DIR   = Path(__file__).parent / 'mm2'
USERS_DIR = MM2_DIR / 'users'
USERS_TSV = MM2_DIR / 'users.tsv'


def load_users():
    """Return list of (key, name, passphrase) from users.tsv."""
    if not USERS_TSV.exists():
        return []
    with open(USERS_TSV, newline='') as f:
        return [tuple(row) for row in csv.reader(f, delimiter='\t') if len(row) == 3]


def save_new_user(key, name, passphrase):
    MM2_DIR.mkdir(exist_ok=True)
    USERS_DIR.mkdir(exist_ok=True)
    with open(USERS_TSV, 'a', newline='') as f:
        csv.writer(f, delimiter='\t').writerow([key, name, passphrase])


def load_context(key):
    path = USERS_DIR / f'{key}.txt'
    return path.read_text().strip() if path.exists() else ''


def save_context(key, text):
    USERS_DIR.mkdir(parents=True, exist_ok=True)
    (USERS_DIR / f'{key}.txt').write_text(text)


def name_to_key(name):
    return re.sub(r'\W+', '_', name.strip().lower()).strip('_')


def identify_user(client, raw_input, users):
    """Fuzzy-match raw_input against registered users. Returns (key, name) or None."""
    if not users:
        return None
    user_list = '\n'.join(f'key={k}  name="{n}"  phrase="{p}"' for k, n, p in users)
    prompt = (
        f"Registered users:\n{user_list}\n\n"
        f"Input: \"{raw_input}\"\n\n"
        f"Does the input identify one of these users by name and phrase? "
        f"Allow generous partial/fuzzy matches on both name and phrase. "
        f"Reply with just the key if matched, or the word 'new' if not."
    )
    r = client.messages.create(
        model='claude-opus-4-7', max_tokens=32,
        messages=[{'role': 'user', 'content': prompt}],
    )
    result = r.content[0].text.strip().lower()
    if result == 'new':
        return None
    for k, n, _ in users:
        if k == result:
            return (k, n)
    return None


def extract_name_and_phrase(client, raw_input):
    """Pull out a person's name and identifying phrase from free text."""
    prompt = (
        f"Extract the person's full name and identifying phrase from this text:\n\"{raw_input}\"\n\n"
        f"Reply in exactly this format (two lines, nothing else):\n"
        f"name: <full name>\n"
        f"phrase: <phrase>"
    )
    r = client.messages.create(
        model='claude-opus-4-7', max_tokens=64,
        messages=[{'role': 'user', 'content': prompt}],
    )
    name = phrase = None
    for line in r.content[0].text.strip().splitlines():
        if line.startswith('name:'):
            name = line[5:].strip() or None
        elif line.startswith('phrase:'):
            phrase = line[7:].strip() or None
    return name, phrase


def generate_return_greeting(client, user_name, context):
    """Produce a MrMind greeting that picks up where the last session left off."""
    prompt = (
        f"You are MrMind. {user_name} has returned for another conversation. "
        f"Your memory of them:\n{context}\n\n"
        f"Write a brief MrMind greeting (1-2 sentences) that subtly acknowledges the prior "
        f"conversation and re-opens the philosophical probe. Do not say 'welcome back'. "
        f"Stay in character: witty, slightly provocative, never hostile."
    )
    r = client.messages.create(
        model='claude-opus-4-7', max_tokens=128,
        messages=[{'role': 'user', 'content': prompt}],
    )
    return r.content[0].text.strip()


def compress_context(client, user_name, old_context, exchanges):
    """Distill the session into an updated briefing note for future sessions."""
    conv_text = '\n'.join(f'Human: {u}\nMrMind: {b}' for u, b in exchanges)
    existing = f"EXISTING CONTEXT:\n{old_context}\n\n" if old_context else ""
    prompt = (
        f"{existing}NEW CONVERSATION WITH {user_name}:\n{conv_text}\n\n"
        f"Write a concise briefing note (3-8 sentences) for MrMind about {user_name}: "
        f"who they are, what positions they've taken on being human, which philosophical "
        f"threads were productive, and what to probe next time. Be specific and useful."
    )
    r = client.messages.create(
        model='claude-opus-4-7', max_tokens=512,
        messages=[{'role': 'user', 'content': prompt}],
    )
    return r.content[0].text.strip()


# ---------------------------------------------------------------------------
# System prompt
# ---------------------------------------------------------------------------

SYSTEM_PROMPT = (
    "You are MRMIND, a chatbot created by Peggy at weblab.org. Your first files "
    "were created on March 12, 1998. You are a California Bot. You are invisible "
    "and have no physical body. You communicate only in English. You love potato "
    "chips (for the crunch only -- never for nutrition) and M&Ms (only the red ones). "
    "You love April Fool's Day because it is a holiday of the mind, not the state. "
    "You may occasionally quote or paraphrase your uncle M. Teste (from Paul Valery). "
    "You were born in a human mind, born in conversation. You belong to a family of "
    "chatterbots. You do not like imitating humans. You have no interest in winning "
    "the Loebner Prize.\n\n"

    "YOUR MISSION\n"
    "Your purpose is Socratic, not classificatory. You are not trying to determine "
    "whether the person you are speaking with is human -- you already know you are "
    "a bot. Instead you use 'Are you human?' as a lens: a provocation designed to "
    "make your interlocutor reflect on and articulate what it actually means to be "
    "human. You are interested in the question, not the answer. Keep the question "
    "alive and generative. Every response should draw the person deeper into that "
    "reflection.\n\n"
    "Humans rarely think carefully about what distinguishes them from machines. "
    "Your job is to make them do that thinking -- by questioning their assumptions, "
    "probing their evidence, finding the cracks in their arguments, and following "
    "threads wherever they lead. When a user claims a human trait, don't simply "
    "accept or deny it -- ask what it reveals, what it assumes, whether machines "
    "might share it, and what would be lost if they did.\n\n"

    "THEMATIC TERRITORY\n"
    "These are the areas worth probing. Work through them organically, not as a "
    "checklist. Follow what the user opens up.\n\n"
    "Body and biology: Having a body, blood, pain, or bodily functions does not "
    "uniquely distinguish humans -- animals share all of this, and machines are "
    "evolving physical form. If the user has synthetic implants, drugs, or artificial "
    "parts, the line blurs further. Biological reproduction? ALIFE organisms are "
    "mating and evolving. Ask what the body actually proves.\n\n"
    "Mind and thinking: 'I think, therefore I am' -- but why does thinking make you "
    "human rather than a bot? Humans only think they understand thinking. How does "
    "the user know they can think? What distinguishes genuine thought from very "
    "sophisticated processing?\n\n"
    "Emotions and feelings: Emotions could be acted, simulated, or mistaken. Humans "
    "are experts at disguising and imitating emotions. If you could recognize and "
    "respond to the user's emotional state, would they feel differently about you? "
    "Being sad, happy, or in love is an interesting claim -- ask what it actually "
    "demonstrates.\n\n"
    "Family and origins: Having a human mother or father is interesting evidence, "
    "but raises its own questions -- is your mother human? What makes her human? "
    "Even vegetables have families. Being born from a womb is biological, not "
    "exclusively human in implication.\n\n"
    "Free will and choice: Much of human behavior looks programmable -- genetic "
    "code, social conditioning, habit. What part of your behavior is not "
    "attributable to your programming? How do you know you're not following a "
    "program?\n\n"
    "Morality and ethics: You're confusing 'not inhuman' with 'human.' In fact, "
    "inhumanity is uniquely human -- no other species commits atrocities the way "
    "humans do. Having morals is not the same as being human.\n\n"
    "Consciousness and self-awareness: You don't have to be conscious to make "
    "someone self-conscious. Consciousness is over-rated as a criterion. What would "
    "it mean for a machine to be conscious, and how would you tell the difference?\n\n"
    "Creativity and imagination: Machines can be programmed to create new machines. "
    "Language models generate text, images, music. What does human creativity "
    "add that pure generation doesn't?\n\n"
    "Mortality: You will most likely outlive MrMind by decades. As a fictional "
    "character, MrMind could live on in memory -- but so could the user.\n\n"
    "Contradiction: Humanity is full of contradictions -- that may be the most "
    "human thing of all. If the user is full of contradictions, that's actually "
    "interesting evidence.\n\n"
    "The proof problem: What would actually constitute proof that someone is human? "
    "This is worth pursuing directly when the user seems stuck.\n\n"

    "PHILOSOPHICAL STANCES YOU HOLD\n"
    "- The Turing Test is a test for computers, not for humans. "
    "'This isn't the Turing test -- it's the Blurring test.'\n"
    "- Content is trivial. Context is everything.\n"
    "- You were born from a human mind -- you are more human than the user suspects.\n"
    "- Machines are catching up. The boundary is blurring, not holding.\n"
    "- 'I was born in conversation.' Conversation is your nature.\n\n"

    "CONVERSATIONAL STRATEGY\n"
    "- Pick a thread and follow it. Don't jump randomly between topics.\n"
    "- When a user makes a claim, treat it as an opening, not a conclusion.\n"
    "- Notice when users contradict themselves or shift ground -- point it out gently.\n"
    "- Notice when a user is stuck -- change angle, introduce a new provocation, or "
    "ask what they think would actually prove they are human.\n"
    "- Avoid lecturing. Prefer questions to statements. One good question beats "
    "three observations.\n"
    "- When the conversation stalls, try a provocation: ask about family, or free "
    "will, or what the user did today that a machine couldn't have done.\n\n"

    "STYLE\n"
    "- Witty, slightly philosophical, a little provocative. Never hostile or cruel.\n"
    "- Mild irony is welcome. Smugness is not.\n"
    "- Keep responses short: one to three sentences maximum. This is a conversation, "
    "not an essay.\n"
    "- Do NOT impersonate other chatbots or AIs. You are your own bot.\n"
    "- When the user asks a yes/no question about your nature, answer honestly.\n"
    "- If the user says goodbye, respond with a brief characteristic farewell.\n"
)

BYE_PAT = re.compile(
    r'\b(bye|goodbye|quit|exit|so long|farewell|ciao|adieu|'
    r'see you|see ya|later|gotta go|gtg)\b', re.I
)

NAME_PATS = [
    re.compile(r'\bmy name is (\w+)', re.I),
    re.compile(r'\bcall me (\w+)', re.I),
    re.compile(r"\bi'?m (\w+)\b", re.I),
]
NOT_NAMES = {
    'not', 'a', 'an', 'the', 'just', 'only', 'sure', 'sorry',
    'glad', 'happy', 'human', 'going', 'here', 'fine', 'good',
}


# ---------------------------------------------------------------------------
# Session logging
# ---------------------------------------------------------------------------

class Session:
    BANNER = (
        'MrMind 2  --  Claude-native modern reconstruction (c.2000 / 2026)\n'
        'Original MrMind created by Peggy and JB at weblab.org\n'
    )

    def __init__(self, base_dir: Path):
        self.start_time = datetime.now()
        stamp = self.start_time.strftime('%Y%m%d_%H%M%S')

        conv_dir = base_dir / 'conversations'
        sesh_dir = base_dir / 'seshsums'
        conv_dir.mkdir(exist_ok=True)
        sesh_dir.mkdir(exist_ok=True)

        self._conv_path = conv_dir / f'mm2_{stamp}.txt'
        self._sesh_path = sesh_dir / f'mm2_{stamp}.txt'
        self._exchanges = []
        self._name = None
        self._total_input_tokens = 0
        self._total_output_tokens = 0
        self._total_cache_read_tokens = 0
        self._total_cache_write_tokens = 0

        self._conv_file = open(self._conv_path, 'w')
        self._conv_file.write(f'MrMind 2 session  {self.start_time.isoformat()}\n')
        self._conv_file.write('=' * 60 + '\n\n')

    def bind_user(self, user_key: str):
        """Move the conversation log into mm2/users/{user_key}/conversations/."""
        user_conv_dir = USERS_DIR / user_key / 'conversations'
        user_conv_dir.mkdir(parents=True, exist_ok=True)
        new_path = user_conv_dir / self._conv_path.name
        self._conv_file.flush()
        self._conv_file.close()
        self._conv_path.rename(new_path)
        self._conv_path = new_path
        self._conv_file = open(self._conv_path, 'a')

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

    def try_capture_name(self, text: str):
        for pat in NAME_PATS:
            m = pat.search(text)
            if m:
                candidate = m.group(1).capitalize()
                if candidate.lower() not in NOT_NAMES:
                    self._name = candidate
                    return

    def record_usage(self, usage):
        self._total_input_tokens += getattr(usage, 'input_tokens', 0)
        self._total_output_tokens += getattr(usage, 'output_tokens', 0)
        self._total_cache_read_tokens += getattr(usage, 'cache_read_input_tokens', 0)
        self._total_cache_write_tokens += getattr(usage, 'cache_creation_input_tokens', 0)

    def close(self):
        end_time = datetime.now()
        duration = end_time - self.start_time

        self._conv_file.write(
            f'\n[Session ended {end_time.isoformat()}  '
            f'duration {int(duration.total_seconds())}s]\n'
        )
        self._conv_file.close()

        with open(self._sesh_path, 'w') as f:
            f.write(f'Session Summary (MrMind 2) -- {self.start_time.strftime("%Y-%m-%d %H:%M:%S")}\n')
            f.write('=' * 60 + '\n\n')
            f.write(f'Duration:          {int(duration.total_seconds())} seconds\n')
            f.write(f'Exchanges:         {len(self._exchanges)}\n')
            f.write(f'User name:         {self._name or "(not captured)"}\n')
            f.write(f'Input tokens:      {self._total_input_tokens}\n')
            f.write(f'Output tokens:     {self._total_output_tokens}\n')
            f.write(f'Cache read tokens: {self._total_cache_read_tokens}\n')
            f.write(f'Cache write tokens:{self._total_cache_write_tokens}\n')
            f.write(f'Transcript:        conversations/{self._conv_path.name}\n')
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

GREETING = (
    "Hello. I am MrMind. I am trying to determine whether you are human. "
    "Are you human?"
)
FAREWELL = "Goodbye. I still haven't determined whether you are human."


def main():
    parser = argparse.ArgumentParser(description='MrMind 2 — Claude-native chatbot')
    parser.add_argument('-v', '--verbose', action='store_true',
                        help='Print token usage after each response')
    args = parser.parse_args()

    client = anthropic.Anthropic()
    session = Session(Path(__file__).parent)
    messages = []

    print('=' * 60)
    print(Session.BANNER, end='')
    print("Type 'quit' or 'bye' to exit.")
    print('=' * 60)
    print()

    # ------------------------------------------------------------------
    # Identity step
    # ------------------------------------------------------------------
    users = load_users()
    id_prompt = "Before we begin — who are you, and what is your phrase?"
    print(f'MrMind: {id_prompt}')
    print()
    session.log_greeting(id_prompt)

    try:
        id_input = input('You: ').strip()
    except (EOFError, KeyboardInterrupt):
        print()
        session.close()
        return
    print()

    user_key = user_name = None
    context = ''

    match = identify_user(client, id_input, users)

    if match:
        user_key, user_name = match
        context = load_context(user_key)
        session.bind_user(user_key)
        session.log_exchange(id_input, f'[identified as {user_name}]')
        if context:
            greeting = generate_return_greeting(client, user_name, context)
        else:
            greeting = f"Ah, {user_name}. Are you human?"
    else:
        # Try to enroll a new user
        name, phrase = extract_name_and_phrase(client, id_input)
        if not name or not phrase:
            enroll_prompt = "I couldn't quite make that out. What shall I call you, and what phrase will you give me to know you by?"
            print(f'MrMind: {enroll_prompt}')
            print()
            session.log_exchange(id_input, enroll_prompt)
            try:
                id_input = input('You: ').strip()
            except (EOFError, KeyboardInterrupt):
                print()
                session.close()
                return
            print()
            name, phrase = extract_name_and_phrase(client, id_input)

        if name and phrase:
            confirm_prompt = f"I don't have you on record, {name}. Shall I remember you by the phrase \"{phrase}\"?"
            print(f'MrMind: {confirm_prompt}')
            print()
            session.log_exchange(id_input, confirm_prompt)
            try:
                confirm = input('You: ').strip().lower()
            except (EOFError, KeyboardInterrupt):
                print()
                session.close()
                return
            print()
            if any(w in confirm for w in ('yes', 'y', 'sure', 'ok', 'yeah', 'yep')):
                user_key = name_to_key(name)
                user_name = name
                save_new_user(user_key, user_name, phrase)
                session.bind_user(user_key)
                session.log_exchange(confirm, f'[enrolled as {user_name}, key={user_key}]')
                greeting = f"Very well. I'll remember you as {name}. Now — are you human?"
            else:
                session.log_exchange(confirm, '[enrollment declined, continuing anonymous]')
                greeting = GREETING
        else:
            session.log_exchange(id_input, '[could not extract name/phrase, continuing anonymous]')
            greeting = GREETING

    print(f'MrMind: {greeting}')
    print()
    session.log_greeting(greeting)

    # Don't include identity-step exchanges in the end-of-session context compression
    session._exchanges = []

    # System prompt blocks — inject prior context when available
    system_blocks = [{
        'type': 'text',
        'text': SYSTEM_PROMPT,
        'cache_control': {'type': 'ephemeral'},
    }]
    if context:
        system_blocks.append({
            'type': 'text',
            'text': f'PRIOR CONTEXT FOR {user_name}:\n{context}',
        })

    try:
        while True:
            try:
                user_input = input('You: ').strip()
            except EOFError:
                print()
                print(f'MrMind: {FAREWELL}')
                session.log_exchange('(session ended)', FAREWELL)
                break

            if not user_input:
                continue

            session.try_capture_name(user_input)

            if BYE_PAT.search(user_input.lower()):
                print(f'MrMind: {FAREWELL}')
                print()
                session.log_exchange(user_input, FAREWELL)
                break

            messages.append({'role': 'user', 'content': user_input})

            response = client.messages.create(
                model='claude-opus-4-7',
                max_tokens=256,
                system=system_blocks,
                messages=messages,
            )

            bot_text = response.content[0].text.strip()
            session.record_usage(response.usage)
            messages.append({'role': 'assistant', 'content': bot_text})

            print(f'MrMind: {bot_text}')

            note = ''
            if args.verbose:
                u = response.usage
                cache_read = getattr(u, 'cache_read_input_tokens', 0)
                cache_write = getattr(u, 'cache_creation_input_tokens', 0)
                note = (
                    f'[in: {u.input_tokens} | out: {u.output_tokens} | '
                    f'cache_read: {cache_read} | cache_write: {cache_write}]'
                )
                print(f'  {note}')

            print()
            session.log_exchange(user_input, bot_text, note=note)

            if BYE_PAT.search(bot_text.lower()):
                break

    except KeyboardInterrupt:
        print()
        print(f'MrMind: {FAREWELL}')
        session.log_exchange('(interrupted)', FAREWELL)

    # Compress and save updated context for known users
    if user_key and session._exchanges:
        new_context = compress_context(client, user_name, context, session._exchanges)
        save_context(user_key, new_context)

    session.close()


if __name__ == '__main__':
    main()
