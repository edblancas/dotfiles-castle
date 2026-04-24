---
name: clipboard-last-output-md
description: Copies the last assistant output to the system clipboard as markdown, with a header containing the user's prompt and the current date/time. Use when the user says "copy to clipboard", "copy last output", or similar.
license: MIT
metadata:
  author: Daniel Blancas
  version: 1.0.0
---

# Clipboard Last Output as Markdown

## Instructions

### Step 1: Get current date and time

```bash
date '+%Y-%m-%d %H:%M'
```

### Step 2: Identify the content to copy

Look at the conversation and find:
- **The user's prompt** that triggered the last substantive assistant response (the one being copied). Use the exact prompt text.
- **The last assistant output** — the full markdown content of the most recent substantive response.

### Step 3: Build the markdown and pipe to pbcopy

Construct the content as:

```
# <user prompt verbatim>
_<YYYY-MM-DD — Weekday HH:MM>_

---

<last assistant output, verbatim>
```

Then copy it using:

```bash
cat << 'CLIPBOARD_EOF' | pbcopy
<constructed content>
CLIPBOARD_EOF
```

### Step 4: Confirm

Reply with a single line: `Copied to clipboard.`

## Rules

- Never truncate or paraphrase the last assistant output — copy it exactly.
- Use the **exact text** of the user's triggering prompt as the header, not a summary of it.
- The weekday should be spelled out, e.g. `Friday`.
- No extra commentary beyond the confirmation line.
