---
name: pr-unresolved-threads
description: Fetch and analyze all unresolved review thread conversations from a GitHub PR, then propose a solution for each one. Use when the user says "get unresolved threads", "show unresolved review comments", "what's unresolved in my PR", "address unresolved conversations", or wants to see which PR review threads are still open.
license: MIT
metadata:
  author: Daniel Blancas
  version: 1.0.0
---

# PR Unresolved Threads

Fetch all unresolved review thread conversations from a GitHub PR and propose solutions for each one.

## Instructions

### Step 1: Parse Input

$ARGUMENTS should be a PR number, a GitHub PR URL, or left blank (in which case use the current branch's open PR).

- If a URL like `https://github.com/Owner/Repo/pull/123` is given, extract owner (`Owner`), repo (`Repo`), and PR number (`123`).
- If only a number is given (e.g., `63344`), infer the owner and repo from `git remote get-url origin`.
- If no argument, run `gh pr view --json number,headRepositoryOwner,headRepository` to get the current PR.

### Step 2: Fetch Unresolved Threads via GraphQL

Run this GraphQL query to get **all unresolved review threads** with their full comment history:

```bash
gh api graphql -f query='
{
  repository(owner: "OWNER", name: "REPO") {
    pullRequest(number: PR_NUMBER) {
      title
      reviewThreads(first: 50) {
        nodes {
          isResolved
          isOutdated
          path
          line
          comments(first: 10) {
            nodes {
              author { login }
              body
              createdAt
            }
          }
        }
      }
    }
  }
}'
```

Replace `OWNER`, `REPO`, and `PR_NUMBER` with the actual values.

Parse the response with Python:

```python
import json, sys, re
data = json.load(sys.stdin)
pr = data["data"]["repository"]["pullRequest"]
threads = pr["reviewThreads"]["nodes"]
unresolved = [t for t in threads if not t["isResolved"]]
print(f"PR: {pr['title']}")
print(f"Total threads: {len(threads)} | Unresolved: {len(unresolved)}\n")
for i, t in enumerate(unresolved, 1):
    print(f"=== THREAD {i}: {t['path']}:{t['line']} [outdated:{t['isOutdated']}] ===")
    for c in t["comments"]["nodes"]:
        # Strip HTML/bot metadata noise from cursor bugbot comments
        body = re.sub(r'<!--.*?-->', '', c["body"], flags=re.DOTALL).strip()
        body = re.sub(r'<div>.*?</div>', '', body, flags=re.DOTALL).strip()
        body = re.sub(r'<details>.*?</details>', '', body, flags=re.DOTALL).strip()
        body = re.sub(r'<sup>.*?</sup>', '', body, flags=re.DOTALL).strip()
        print(f"[{c['author']['login']}]: {body[:600]}")
        print()
    print()
```

### Step 3: Read the Affected Files

For each unresolved thread, read the current state of the file at the indicated path and line number. This is critical — the thread may have been partially addressed since it was opened, so always check the current code before proposing a solution.

Read files in parallel where possible.

### Step 4: Analyze and Propose Solutions

For each unresolved thread:

1. **Identify if it's already resolved in the current code.** If the concern in the comment is no longer present (the code was changed), note it as "likely already addressed — can be resolved."

2. **If it still needs action**, propose a concrete fix with:
   - The exact code change (before/after or a snippet)
   - The file path and approximate line
   - A one-sentence rationale

3. **Categorize priority:**
   - **Fix now** — correctness bug, crashes, type safety, security
   - **Refactor** — code quality, use existing utility, nit
   - **Document** — add a comment explaining a constraint or decision
   - **Followup** — reviewer explicitly said "can be done in a followup"
   - **Resolve (no change)** — code already addressed it, or it's a misunderstanding

### Step 5: Present Results

Output the analysis in this format:

```
## Unresolved Threads — PR #<number>: <title>
<N> threads need attention

---

### Thread 1 — <short title of issue>
**Author:** <login>  
**File:** `<path>:<line>`  
**Priority:** Fix now | Refactor | Document | Followup | Resolve (no change)

**Comment:** "<first comment body, trimmed>"

**Current code:**
```<lang>
<current code at that location>
```

**Analysis:** <what the reviewer is asking, whether it's still an issue>

**Proposed solution:** <concrete fix or action>

---
```

End with a **summary table**:

| # | Issue | Author | Priority | File |
|---|-------|--------|----------|------|
| 1 | ... | ... | Fix now | `file.ts` |

## Notes

- Strip bot noise (HTML tags, Cursor Bugbot metadata blocks) from comment bodies when displaying.
- If a thread has replies, read the full exchange — later replies may indicate the original concern was addressed or evolved.
- For Cursor Bugbot threads: the important part is usually the `<!-- DESCRIPTION START -->` to `<!-- DESCRIPTION END -->` block. Extract just that.
- Threads marked `isOutdated: true` are on code that no longer exists in the diff but were not explicitly resolved. Note them as outdated but still show them.
- If there are more than 50 threads, paginate using the `after` cursor in GraphQL.
