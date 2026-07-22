# Templates

Reusable `CLAUDE.md` / `AGENTS.md` project-instruction files. Each one should be a
self-contained set of instructions for a specific kind of project (stack,
conventions, quality bar) that you can drop into a new repo as a starting point.

The first example is `expo-react-native-teaching-app.md` (Expo/React Native
teaching-app instructions).

Not symlinked anywhere — copy the one you want into a project as its
`CLAUDE.md`/`AGENTS.md`:

```bash
cp ~/.dotfiles/claude/templates/<name>.md /path/to/project/CLAUDE.md
```

## Adding a new template

1. Name the file after the stack/purpose, e.g. `expo-react-native.md`,
   `python-fastapi.md`.
2. Keep it scoped to one kind of project — don't try to make one file cover
   everything.
