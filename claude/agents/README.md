# Agents

Claude Code subagent definitions — markdown files with frontmatter, matching the
`.claude/agents/*.md` format.

## Available

| File | Role |
| --- | --- |
| `full-stack-developer.md` | End-to-end feature implementation, frontend + backend |
| `backend-tester.md` | Writes/runs tests for server code |
| `frontend-tester.md` | Writes/runs tests for UI code |
| `architecture-reviewer.md` | Checks structure/conventions against the project's architecture (review only) |
| `senior-developer.md` | High-level code review — correctness, maintainability, design tradeoffs (review only) |
| `senior-uiux-designer.md` | UI/UX review and guidance — design fidelity, accessibility, consistency |
| `project-manager.md` | Breaks down work, tracks status, surfaces risks (no code) |
| `technical-writer.md` | Writes/maintains docs |
| `security-reviewer.md` | Reviews for OWASP-style vulnerabilities (review only) |
| `devops-engineer.md` | CI/CD, deployment, containers, infrastructure-as-code |
| `performance-engineer.md` | Profiles and fixes backend/frontend performance issues |

The "reviewer"-style agents (`architecture-reviewer`, `senior-developer`,
`security-reviewer`) are deliberately read-only — they report findings rather
than editing code, so they stay independent of whoever wrote the change.

All descriptions are currently phrased for **manual invocation only** — none
say "use PROACTIVELY", so Claude Code should not auto-delegate to them. Invoke
by name (e.g. "use the security-reviewer agent on this diff") or via `/agents`.
If you later want a given agent to be triggered automatically when its
situation comes up, add "Use PROACTIVELY ..." back into its `description`.

This folder is symlinked in as `~/.claude/agents` (see `../../setup-mac.sh`),
so every file here is live globally — no copy step needed after editing.

## Format

```markdown
---
name: agent-name
description: One line describing when to use this agent.
tools: Read, Grep, Glob   # optional; omit to inherit all tools
model: sonnet             # optional override
---

System prompt / instructions for the agent go here.
```

## Adding a new agent

Create `<name>.md` in this folder following the format above — it becomes
available globally as soon as the file is saved, since the folder is
symlinked into `~/.claude/agents`.
