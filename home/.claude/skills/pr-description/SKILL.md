---
name: pr-description
description: Generates a conventional commit title and a formatted PR description in markdown. Use when the user says "create a pr description", "write a pr description", "generate a PR description", or asks for a pull request description for their changes. Outputs a conventional commit title followed by a full markdown body in a fenced code block.
license: MIT
metadata:
  author: Daniel Blancas
  version: 1.0.0
---

# PR Description

## CRITICAL Rules

- **Always** output a conventional commit title first, outside the code block, e.g.:
  `fix(temporal): fix temporal namespace format to use hyphens instead of underscores`
- **Always** wrap the full description body in a fenced `\`\`\`markdown` block so it renders correctly when pasted into GitHub.
- Never output the description as plain prose — it must be inside the code block.

## Instructions

### Step 1: Gather Context

Run the following in parallel:

```bash
git log --oneline $(git merge-base HEAD origin/develop 2>/dev/null || git merge-base HEAD origin/main 2>/dev/null || git merge-base HEAD origin/master 2>/dev/null)..HEAD
git diff $(git merge-base HEAD origin/develop 2>/dev/null || git merge-base HEAD origin/main 2>/dev/null || git merge-base HEAD origin/master 2>/dev/null) --stat
git diff $(git merge-base HEAD origin/develop 2>/dev/null || git merge-base HEAD origin/main 2>/dev/null || git merge-base HEAD origin/master 2>/dev/null)
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

Output the title as plain text (not inside the code block).

### Step 3: Write the PR Description Body

Structure the body as follows and output it inside a fenced `\`\`\`markdown` block:

````
```markdown
## <Title restated as a heading>

### Problem

<1-3 sentences explaining why the change was needed. Include error messages or failure modes if relevant.>

### Changes

- **`<file or package>`** — <what changed and why>
- **`<file or package>`** — <what changed and why>

### Test plan

- [ ] `<test command>` passes
- [ ] <Manual verification step if applicable>
```
````

## Example

User says: `"create a pr description for my changes"`

1. Run git commands to inspect commits and diff.
2. Derive type (`fix`), scope (`temporal`), short description.
3. Output:

`fix(temporal): fix temporal namespace format to use hyphens instead of underscores`

````markdown
```markdown
## Fix Temporal namespace format to use hyphens instead of underscores

### Problem

The Temporal Helm chart uses the namespace name to construct Kubernetes Job
resource names. RFC 1123 label validation rejects underscores, causing
namespace creation to fail.

### Changes

- **`temporal-node/src/namespace/resolve-namespace.ts`** — join segments with `-`; validate no underscores in useCase, domain, or environment.
- **`temporal-node/__tests__/namespace/resolve-namespace.test.ts`** — update expected values; add underscore rejection tests.
- **`temporal-node/README.md`** — update format strings and examples.

### Test plan

- [ ] `nx test temporal-node --testFile=resolve-namespace.test.ts` passes (11 tests)
- [ ] Verify namespace creation succeeds via the Helm chart after deploy
```
````

## Common Issues

### No remote branch to diff against
If `git merge-base HEAD origin/develop` fails, try `origin/main`, `origin/master`, or ask the user which base branch to diff against.

### Changes span many packages
Keep the Changes section focused on the most significant files. Group minor changes under a single bullet (e.g., "Updated README and naming convention tables across `temporal-node` and `temporal-task-queues-node`").
