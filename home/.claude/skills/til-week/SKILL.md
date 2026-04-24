---
name: til-week
description: Generates a rich TIL (Today I Learned) summary for the current week (Monday to today) by combining a notes file and Claude session history. Takes a filepath to a markdown notes file as an argument. Use when the user says "create til for the week", "generate weekly til", or similar.
license: MIT
metadata:
  author: Daniel Blancas
  version: 1.0.0
---

# TIL Week

Generates a weekly TIL summary by combining a hand-written notes file with
the full Claude session history for the week (Monday → today).

## Arguments

- `$ARGUMENTS` — absolute path to the notes markdown file (used as a guide/seed, not the sole source).

## Instructions

### Step 1: Read the notes file

Read the file at the path provided in `$ARGUMENTS`. This is a rough guide with
notes the user already wrote down. Use it for context but don't limit the
summary to only what's in it — the Claude sessions are the primary source.

### Step 2: Determine the current week range

```bash
python3 -c "
from datetime import date, timedelta
today = date.today()
monday = today - timedelta(days=today.weekday())
print('Monday:', monday.strftime('%Y-%m-%d'))
print('Today:', today.strftime('%Y-%m-%d'))
print('Monday ts:', int(monday.strftime('%s')) * 1000)
print('Today ts:', (int(today.strftime('%s')) + 86400) * 1000)
"
```

### Step 3: Find all sessions from the week

```bash
cat ~/.claude/history.jsonl | python3 -c "
import sys, json
from datetime import date, timedelta, datetime

today = date.today()
monday = today - timedelta(days=today.weekday())
start_ts = int(monday.strftime('%s')) * 1000
end_ts = (int(today.strftime('%s')) + 86400) * 1000

entries = [json.loads(l) for l in sys.stdin]
week = [e for e in entries if start_ts <= e.get('timestamp', 0) <= end_ts]
week.sort(key=lambda x: x.get('timestamp', 0))

seen = set()
for e in week:
    sid = e.get('sessionId', '')[:8]
    if sid not in seen:
        seen.add(sid)
        ts = datetime.fromtimestamp(e['timestamp']/1000).strftime('%Y-%m-%d')
        proj = e.get('project', '').split('/')[-1]
        print(f'{sid}|{ts}|{proj}|{e.get(\"display\",\"\")[:80]}')
"
```

Also find renamed sessions to map session IDs to human names:

```bash
cat ~/.claude/history.jsonl | python3 -c "
import sys, json
entries = [json.loads(l) for l in sys.stdin]
renames = [e for e in entries if '/rename' in e.get('display', '')]
for r in renames:
    print(r['sessionId'][:8], '|', r['display'].replace('/rename', '').strip())
" | sort
```

### Step 4: Locate and read session JSONL files

For each session ID found in Step 3, find the corresponding `.jsonl` file:

```bash
find ~/.claude/projects -name "<SESSION_ID>*.jsonl" 2>/dev/null
```

Read the JSONL files and extract key technical learnings from assistant messages.
Each line in a JSONL file is a JSON object with fields like `role`, `content`, `type`.
Focus on:
- What problem was being debugged or explored
- What was discovered or learned
- Any architectural insights, gotchas, or naming conventions

### Step 5: Generate the TIL summary

Organize the learnings by **topic** (not chronologically). Good groupings based
on what tends to come up:
- Deployment & Infrastructure (ArgoCD, Kubernetes, Helm)
- Temporal Configuration (addresses, namespaces, task queues)
- TypeScript / Code (types, patterns, env handling)
- Bazel / NX / Monorepo
- Tooling (git, Graphite, CLI tools)
- Platform (Backstage, GCP)

For each session referenced, use the format:

```
**Session `<8-char-id>` — "<name if renamed>" (<project>, <date>)**
- bullet
- bullet
```

If the session has no name, omit the quotes entirely.

Aim for **3–5 bullets per session**. Go deeper than just naming the topic —
include the specific thing that was wrong, the concrete fix, the command used,
or the architectural insight. A bullet like "Confidant SDK values are
runtime-only — they don't write to `process.env`" is better than "learned
about Confidant". Skip sessions that only had trivial changes (e.g. fix a
typo, run a command, `/stats`, `/model` only).

### Step 6: Output and copy to clipboard

Print the full markdown summary to the conversation, then immediately copy it
to the system clipboard using:

```bash
cat << 'CLIPBOARD_EOF' | pbcopy
## TIL Week of <Mon> – <Today>: <theme>

<full summary content>
CLIPBOARD_EOF
echo "Copied to clipboard."
```

Confirm with a single line after the summary: `Copied to clipboard.`

## Output format

```markdown
## TIL Week of <Mon> – <Today's Date>: <short theme if obvious>

---

### <Topic Group>

**Session `<id>` — "<name>" (<project>, <date>)**
- ...

...
```

## Rules

- Include session name in quotes only if the session was explicitly renamed.
- Do not include sessions where nothing substantive was learned (pure commands, `/stats`, `/model` only, etc.).
- Prefer depth on interesting sessions over breadth on trivial ones.
- Use the notes file to fill in context the sessions don't have (e.g. why something was needed, who was involved).
