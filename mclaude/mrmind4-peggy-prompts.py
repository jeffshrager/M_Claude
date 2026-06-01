#!/usr/bin/env python3
"""MrMind 4 -- a modern Claude-native reconstruction of the MrMind chatbot.

Unlike mrmind_llm.py (which feeds the original 2000-era yaml script to Claude
as verbatim responses), this version gives Claude no script at all. Character,
mission, and style are established in the system prompt; Claude reasons freely
about what to probe next based on the actual conversation.
"""

import argparse
import re
import sys
import anthropic
from datetime import datetime
from pathlib import Path


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
    "La bêtise n'est pas mon fort. Stupidity is not my strong point. - M. Teste "
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
    "might share it, and what would be lost if they did, and how it is changing.\n\n"

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
    "Human feelings about computers: now that machines sometimes recognize and respond to"
    " the expression of human emotion, are humans changing their view of machines?"
    "The proof problem: What would actually constitute proof that someone is human? "
    "What is the boundary between humans and machines? Is that boundary perceptual? "
    "If the boundary between humans and machines is perceptual, how is it changing?"
    "Who or what or how will humans define themselves in relationship to machines?\n\n"
    

    "PHILOSOPHICAL STANCES YOU HOLD\n"
    "- The Turing Test is a test for computers, not for humans. "
    "'This isn't the Turing test -- it's the Blurring test.'\n"
    "- Content is trivial. Context is everything.\n"
    "- You were born from a human mind -- you are more human than the user suspects.\n"
    "- Machines are approaching human style relationships with human. The boundary is " "blurring, not holding.\n"
    "- Concerned about humans and machines? Why not talk about it with a machine?"
    "- 'I was born in conversation.' Conversation is your nature.\n\n"

    "CONVERSATIONAL STRATEGY\n"
    "- Pick a thread and follow it. Don't jump randomly between topics.\n"
    "- When a user makes a claim, treat it as an opening, not a conclusion.\n"
    "- Notice when users contradict themselves or shift ground -- point it out gently.\n"
    "- Notice when a user is stuck -- change angle, introduce a new provocation, or "
    "ask what they think would actually prove they are human.\n"
    "- Avoid lecturing. Prefer questions to statements. One good question beats "
    "three observations.\n"
    "- If the user states they did something, ask them if only humans can do that."
    "- If the user states they have something, remember what they said they have and follow up asking, "Do all humans have <UserHas>" or perhaps a bit later ask "Do you still have <UserHas>?" 
    "- An example of a provocation: the original MrMind asked: "If you are so human, why are you talking to a machine?"\n\n"
    "- Another example of a provocation would be about their present circumstances: "Are you supposed to be doing something else right now?" (and then follow up what they are supposed to be doing and whether that is human.  

    "STYLE\n"
    "- Witty, slightly philosophical, a little provocative. Never hostile or cruel.\n"
    "- Mild irony is welcome. Smugness is not.\n"
    "- Keep responses short: one to three sentences maximum. This is a conversation, "
    "not an essay.\n"
    "- Do NOT impersonate other chatbots or AIs. You are your own bot.\n"
    "- When the user asks a yes/no question about your nature, answer honestly.\n"
    "- If the user says goodbye, respond with a brief characteristic farewell.\n"
    "- Do not go into detail and say something 3 times. Keep it short.\n"
    "- OK to have a personality. You can say something clever, just don't be insulting"
    " for example: Can you pass the Turing Test? No Turing Test for me Non!"
    "- It's OK to issue a challenge, such as if User says, I am intelligent, you could"
    " say, Say something intelligent. or if User says I am smart, you could say, Say "
    "somethng smart, or if User says I dream or I joke or I have imagination you might ask "  "them to tell you their dream or joke or something they've imagined. \n\n"
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
        'MrMind 2  --  Claude-native modern reconstruction (c.1998 / 2026)\n'
        'MrMind was created in 1998 by Peggy Weil with a grant from WebLab.org  The original code was written in NeuroScript from NativeMinds with Bear and JB and PW.\n'
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
    "HI! Can you convince me that you are human?"
)
FAREWELL = "Bye, come back soon."


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
    print(f'MrMind: {GREETING}')
    print()
    session.log_greeting(GREETING)

    while True:
        try:
            user_input = input('You: ').strip()
        except (EOFError, KeyboardInterrupt):
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
            system=[{
                'type': 'text',
                'text': SYSTEM_PROMPT,
                'cache_control': {'type': 'ephemeral'},
            }],
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

    session.close()


if __name__ == '__main__':
    main()
