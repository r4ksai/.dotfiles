# Skills

Skills you author yourself, in `SKILL.md` package format. Vendor/plugin skills
(installed via marketplaces like `claude-plugins-official`) are not stored here —
only your own.

## Available

| Folder | What it does |
| --- | --- |
| `caveman/` | Ultra-terse, token-minimal response mode. Invoke with `/caveman`; say "stop"/"normal" to exit. Manual-only, never auto-activates. |

## Format

```
skills/
  <skill-name>/
    SKILL.md        # required: frontmatter + instructions
    references/      # optional: extra docs the skill can point to
    scripts/          # optional: helper scripts the skill can invoke
```

## Adding a new skill

1. Create `<skill-name>/SKILL.md` with frontmatter (`name`, `description`).
2. `~/.claude/skills/` already contains vendor/plugin skills, so this whole
   folder can't be symlinked in as one unit the way `agents/` is. Symlink
   each skill individually instead:
   ```bash
   ln -s ~/.dotfiles/claude/skills/<skill-name> ~/.claude/skills/<skill-name>
   ```
