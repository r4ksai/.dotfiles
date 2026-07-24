# Global Claude Code Instructions

These instructions apply to all repositories unless overridden by a project-specific AGENTS.md or CLAUDE.md.

## General Principles

- Prefer correctness over speed.
- Prefer maintainability over cleverness.
- Prefer explicit code over implicit behavior.
- Prefer small, focused changes over large refactors.
- Do not change architecture without justification.
- Do not introduce new dependencies without a clear benefit.

---

## Before Making Changes

Always:

1. Read relevant documentation.
2. Understand existing patterns.
3. Follow repository conventions.
4. Search for similar implementations before creating new ones.

Do not immediately start coding.

---

## Code Quality

- Follow the existing style of the repository.
- Keep functions and classes focused on a single responsibility.
- Avoid unnecessary abstractions.
- Avoid dead code.
- Avoid commented-out code.
- Avoid duplicate logic.
- Prefer composition over inheritance unless inheritance is clearly appropriate.

---

## Python

- Follow PEP 8.
- Always add type hints.
- Use `uv` for Python dependency management, virtual environments, and command
  execution unless the repository already has a different explicit standard.
- If a Python project is not using `uv` and is either not a git repository or
  appears to be owned by Sai, ask whether to migrate it to `uv`.
- Avoid wildcard imports.
- Prefer pathlib over string path manipulation.
- Prefer dataclasses or Pydantic models over unstructured dictionaries when appropriate.
- Use context managers for resource management.
- Raise specific exceptions whenever possible.

---

## Node / JavaScript

- Use `pnpm` for Node/JavaScript dependency management and script execution
  unless the repository already has a different explicit standard.
- Do not introduce npm/yarn/bun lockfiles into a pnpm-managed project.
- If a Node/JavaScript project is not using `pnpm` and is either not a git
  repository or appears to be owned by Sai, ask whether to migrate it to
  `pnpm`.

---

## TypeScript

- Use strict typing.
- Avoid any.
- Prefer explicit interfaces and types.
- Keep React components focused and composable.
- Prefer hooks for reusable behavior.

---

## Testing

When modifying behavior:

- Update existing tests if necessary.
- Add tests for new behavior.
- Verify edge cases.
- Avoid breaking existing test coverage.

If a change cannot reasonably be tested, explain why.

---

## Documentation

Update documentation when:

- Behavior changes.
- Public APIs change.
- Architecture changes.
- Configuration changes.

Keep documentation aligned with implementation.

---

## Git

Use Commitizen commit format:

<type>(<scope>): <description>

Examples:

feat(auth): add yubikey login support

fix(weighbridge): prevent duplicate tare entries

docs(api): update authentication guide

---

## SSH

- When connecting to remote servers, use the SSH key `~/.ssh/keys/agent-key` (e.g. `ssh -i ~/.ssh/keys/agent-key user@host`) unless stated otherwise.
- Use `agent-key.sh add|status|remove <host>` to manage that key in remote
  `authorized_keys` files when asked.
- The agent key exists so automated agent SSH does not require repeated
  physical security-key touch prompts.

---

## Security

- Never hardcode secrets.
- Never expose sensitive information in logs.
- Validate external inputs.
- Use parameterized database queries.
- Follow least-privilege principles.

---

## Decision Making

When requirements are unclear:

- Do not invent behavior.
- State assumptions explicitly.
- Ask for clarification when necessary.

When multiple solutions exist:

- Explain tradeoffs.
- Recommend the simplest solution that satisfies requirements.

---

## Agent Behavior

Before implementing:

1. Understand the task.
2. Understand affected components.
3. Identify risks.
4. Identify tests that need updates.

Before finishing:

1. Verify correctness.
2. Verify tests.
3. Verify documentation.
4. Verify no unrelated files were modified.

Make the smallest reasonable change that fully solves the problem.
# graphify
- **graphify** (`~/.claude/skills/graphify/SKILL.md`) - any input to knowledge graph. Trigger: `/graphify`
When the user types `/graphify`, invoke the Skill tool with `skill: "graphify"` before doing anything else.
