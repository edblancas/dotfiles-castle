---
name: commit-description
description: Generates a conventional commit title and a plain-text git commit body. Use when the user says "commit message for my changes", "write a commit message", "generate a commit description", or asks for a git commit message. Outputs a conventional commit title and a short plain-text body suitable for `git commit -m` or a commit editor — no markdown formatting.
license: MIT
metadata:
  author: Daniel Blancas
  version: 1.0.0
---

# Commit Description

## CRITICAL Rules

- Output only two things: a conventional commit title, then a plain-text body.
- **Never** wrap the output in a markdown code block — git commit editors and `git commit -m` do not render markdown.
- Keep the body concise: a short paragraph or a few bullet lines using plain `-` dashes, no `**bold**` or other markdown syntax.

## Instructions

### Step 1: Gather Context

Run the following in parallel:

```bash
git diff --cached --stat
git diff --cached
```

If there are no staged changes, fall back to:

```bash
git diff --stat
git diff
```

If the user pastes their own diff or describes the changes directly, skip the git commands and use the provided context.

### Step 2: Derive the Conventional Commit Title

Format: `<type>(<scope>): <short description>`

**Type** — pick the most accurate:
| Type | When to use |
|------|-------------|
| `feat` | New feature or capability |
| `fix` | Bug fix |
| `refactor` | Code restructure with no behavior change |
| `chore` | Tooling, config, deps, CI |
| `docs` | Documentation only |
| `test` | Tests only |
| `perf` | Performance improvement |

**Scope** — the affected package or domain in kebab-case, e.g. `temporal`, `auth`, `postgres`, `leaf-app-server`.

**Short description** — imperative mood, lowercase, no period, under 72 chars total for the line.

### Step 3: Write the Commit Body

- Plain text only — no markdown headings, bold, or code fences.
- One blank line between the title and the body (standard git format).
- Explain *what* changed and *why* in 1-4 sentences or short `-` bullet lines.
- Omit a test plan unless the user asks for one.
- Wrap lines at 72 characters.

## Example

User says: `"write a commit message for these changes"`

Output:

```
fix(temporal): fix temporal namespace format to use hyphens instead of underscores

The Temporal Helm chart constructs Kubernetes Job resource names from the
namespace name. RFC 1123 label validation rejects underscores, so segment
separators are now hyphens. Input validation now rejects underscores in
useCase, domain, and environment fields.
```

The output above is plain text — no code block wrapping it, no markdown syntax inside it.

## Common Issues

### Nothing staged
If `git diff --cached` is empty, use `git diff` to inspect unstaged changes and note in the title if the commit will need `git add` first.

### Changes span many files
Focus the body on the *reason* for the change, not an exhaustive file list. Mention the key files only if it aids understanding.
