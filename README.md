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
python3 mrmind.py
```

### `mrmind_llm.py` — Claude-powered engine

Uses the Anthropic API (claude-opus-4-7) to role-play MrMind. Same rules file
feeds a system prompt; Claude improvises within the character. Requires an
`ANTHROPIC_API_KEY` environment variable.

```
python3 mrmind_llm.py
```

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

### Testing a change

Run `python3 mrmind.py` (no API key needed) and exercise the new rule. The
ELIZA version is fast for iteration. Once the rule feels right, the LLM version
will pick it up automatically — it reads the same `mrmind.yaml` to build its
system prompt.

---

## Source files

The `A_Q/`, `Q_A/`, `Defaults/`, `JB-added/`, `utilities/`, and `*.g`/`*.tlx`
files are the original 2000-era sources in the proprietary weblab DSL. They
are preserved for reference; the reconstruction in `mrmind.yaml` was drawn
from them.
