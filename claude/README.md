# Claude Code config

Personal Claude Code configuration, version-controlled as part of this
dotfiles repo.

```
CLAUDE.md    Global instructions, symlinked to ~/.claude/CLAUDE.md
agents/      Subagent definitions, symlinked as ~/.claude/agents (whole folder)
skills/      Self-authored skills, each symlinked individually into ~/.claude/skills
templates/   CLAUDE.md/AGENTS.md starting points, copied into a project on demand
prompts/     Standalone task prompts, copied/pasted on demand
```

See each subfolder's README for the format and how to add to it.

## Symlink setup

Handled by `setup-mac.sh` (`_link` calls) so a fresh machine picks these up
automatically via `install.sh`. To (re)link manually on this machine:

```bash
ln -sf ~/.dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/.dotfiles/claude/agents ~/.claude/agents
```
