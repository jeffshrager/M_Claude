# MrMind

A reconstruction of the MrMind chatbot (circa 2000), originally created by
Peggy and JB at weblab.org.

MrMind's conceit is not a literal reverse Turing test. It uses "Are you human?"
as a Socratic provocation — a lens for drawing out your own thinking about what
it means to be human. It is witty, slightly philosophical, and never hostile.

---

## Two versions

### `mrmind.py` — ELIZA-style engine

Pattern-matching chatbot. Reads rules from `mrmind.yaml` and responds using
keyword matching and regex patterns. No network connection required.

```
python3 mrmind.py [-v | --verbose]
```

Pass `-v` to enable verbose mode (see [Verbose mode](#verbose-mode) below).

### `mrmind_llm.py` — Claude-powered engine (script-guided)

Uses the Anthropic API (claude-opus-4-7) to role-play MrMind. The same
`mrmind.yaml` rules file is fed into the system prompt as verbatim responses
for Claude to draw from. Requires an `ANTHROPIC_API_KEY` environment variable.

```
python3 mrmind_llm.py
```

### `mrmind2.py` — Claude-native engine (self-contained)

A modern reconstruction with no script at all. The character, Socratic mission,
and full thematic territory are baked into a rich system prompt inside the file;
Claude reasons freely about what to probe next based on the actual conversation.

**This file is fully self-contained** — no yaml or other files needed. You can
hand it to another user and it will work with just:

```
pip install anthropic
export ANTHROPIC_API_KEY=sk-ant-...
python3 mrmind2.py [-v | --verbose]
```

Verbose mode prints token and cache usage after each response (useful for
monitoring API cost). Logs are written to `conversations/` and `seshsums/`
next to wherever the script lives.

---

## Dependencies

```
pip install pyyaml anthropic
```

`pyyaml` is required by both versions. `anthropic` is only needed for the LLM
version.

---

## What gets logged

Both versions write two files automatically at the end of each session:

| Directory | Contents |
|-----------|----------|
| `conversations/` | Full transcript of the session |
| `seshsums/` | Short summary: duration, exchanges, rules fired, first/last turn |

LLM sessions are prefixed `llm_` to distinguish them from ELIZA sessions.
Files are named by timestamp, e.g. `20260518_142300.txt`.

---

## Rules file: `mrmind.yaml`

All response logic lives here. Each rule has:

- `id` — unique name
- `priority` — higher fires first (default 50)
- `keywords` — fast pre-filter; any must appear in the input
- `patterns` — list of regexes; first match wins
- `responses` — cycled through on successive matches
- `followup` — optional yes/no/maybe branch for the next turn

The `meta` section holds the greeting, farewell, defaults (fallback lines),
`stall_threshold`, and `topic_starters` (proactive conversation openers used
after N consecutive unmatched turns).

---

## Making changes

All behavior changes go in `mrmind.yaml`. You rarely need to touch the Python.

### Edit an existing response

Find the rule by its `id`, then add, remove, or reorder lines in `responses`.
Responses cycle in order on repeated matches, so put the strongest line first.

### Add a new rule

Append a block under `rules:` (order within the file doesn't matter — `priority`
controls firing order):

```yaml
  - id: my_new_rule
    priority: 60          # 50 is default; higher fires before lower
    keywords: [memory, remember, forget]
    patterns:
      - '\b(remember|forget|memory|memories)\b'
    responses:
      - Do machines remember, or do they merely store?
      - Is a memory still yours if you can't recall it?
```

`keywords` is a fast pre-filter — at least one must appear in the input before
patterns are tried. If you omit `patterns`, a keyword match alone fires the rule.

### Add a yes/no follow-up branch

```yaml
    responses:
      - Have you ever been in love?
    followup:
      prompt: Would you say love is uniquely human?
      yes: So love is your proof of humanity. Interesting.
      no: Then what is?
      maybe: A philosopher's answer. I respect that.
```

After the first response fires, MrMind treats the user's next turn as a
yes/no/maybe and replies from the matching branch.

### Tune the stall behaviour

In the `meta` section:

```yaml
meta:
  stall_threshold: 2      # proactively introduce a topic after N consecutive unmatched turns
  topic_starters:
    - "Let's play 20 questions. Think of something — is it alive?"
    - What's the most human thing you did today?
```

Add new topic starters to the list; they cycle in order.

### Change greeting, farewell, or defaults

Also in `meta`:

```yaml
meta:
  greeting: Hello. I am MrMind. Are you human?
  farewell: Goodbye. I still haven't determined whether you are human.
  defaults:
    - Tell me something human about yourself.
    - What makes you say that?
```

`defaults` cycle when no rule matches and the stall threshold hasn't been hit.

### Assign a rule to a subject

Rules with a common theme can be grouped under a `subjects:` tag. When a
focused rule fires, the engine preferentially tries other rules in the same
subject before falling back to normal matching. This lets MrMind pursue a line
of inquiry across several turns.

```yaml
  - id: user_has_body
    priority: 69
    subjects: [BODY]
    focus: BODY          # sets focus when this rule fires
    keywords: [body, physical, flesh, skin]
    ...
```

Existing subjects and which rules belong to them:

| Subject | What it covers |
|---------|---------------|
| `BODY` | Physical attributes — body, brain, bellybutton, bleeding, pain, bodyfunctions, mammal |
| `MIND` | Thinking/cognition — thinking, cogito, consciousness, imagination, creativity, wonder, learning |
| `EMOTIONS` | Feelings — emotions, food, sex, fictional love |
| `FAMILY` | Family relationships — mother, father, family |
| `CONVINCING` | Proving humanity — convincing, proving, Turing test |
| `HUMANITY` | What it means to be human — definitions, why it matters |
| `MORALS` | Ethics/spirituality — morals, truth, God, contradictions |
| `BOTS` | MrMind's own nature — scripted, can't think/emote, what is a bot |

### Set focus when a rule fires

Add `focus: SUBJECT` to a rule to make the next turn prefer rules in that
subject. The user can still match any rule — focus just gives subject-mates
first crack.

```yaml
    focus: FAMILY   # next turn checks FAMILY rules before others
```

### Clear focus

Add `clear_focus: true` to reset attention (returns to normal matching). Use
this on escape hatches like profanity, "never mind", or hint requests.

```yaml
  - id: never_mind
    priority: 46
    clear_focus: true
    ...
```

### Testing a change

Run `python3 mrmind.py` (no API key needed) and exercise the new rule. The
ELIZA version is fast for iteration. Once the rule feels right, the LLM version
will pick it up automatically — it reads the same `mrmind.yaml` to build its
system prompt.

---

## Verbose mode

Run with `-v` or `--verbose` to print a diagnostic line after every response:

```
MrMind: Fine, is she human?  Is your mother human?
  [rule: user_has_mother | focus: FAMILY | followup: "Is your mother human?"]

MrMind: Even vegetables have families.
  [rule: user_has_family (*focus boosted*) | focus: FAMILY]

MrMind: Tell me something human about yourself.
  [rule: __default__ | focus: FAMILY | stall: 1/2]
```

**Fields:**

| Field | Meaning |
|-------|---------|
| `rule: <id>` | Which rule fired. Special values: `__default__` (fallback line), `__topic_starter__` (proactive topic intro), `__followup__` (yes/no branch handled), `__farewell__` (bye) |
| `(*focus boosted*)` | Focus caused this rule to win — it was found in the first pass because its subjects matched the active focus. Absent means the rule won on its own in the second pass. |
| `focus: <SUBJECT>` | The current focused subject, or `none`. A focus active but no boost flag means the user said something that broke out of the focused subject. |
| `followup: "..."` | A yes/no/maybe branch is now armed; shows the prompt MrMind just asked. The next user turn will be intercepted before normal pattern matching. |
| `stall: N/T` | N consecutive unmatched turns so far; T is the threshold. When N reaches T a topic starter fires instead of another default. |

Reading focus: the three meaningful combinations are:

```
[rule: user_has_father (*focus boosted*) | focus: FAMILY]   # focus did the work
[rule: user_bleeds | focus: FAMILY]                         # focus active but irrelevant this turn
[rule: user_has_body | focus: none]                         # no focus at all
```

---

## Source files

The `A_Q/`, `Q_A/`, `Defaults/`, `JB-added/`, `utilities/`, and `*.g`/`*.tlx`
files are the original 2000-era sources in the proprietary weblab DSL. They
are preserved for reference; the reconstruction in `mrmind.yaml` was drawn
from them.
