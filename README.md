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

## Source files

The `A_Q/`, `Q_A/`, `Defaults/`, `JB-added/`, `utilities/`, and `*.g`/`*.tlx`
files are the original 2000-era sources in the proprietary weblab DSL. They
are preserved for reference; the reconstruction in `mrmind.yaml` was drawn
from them.
