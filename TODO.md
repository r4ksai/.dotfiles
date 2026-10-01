# TODO

- [ ] Switch `lsd` → `eza` for file icons (or add a `theme.yml`) so `.v`/`.sv`/`.cst`
      get real icons instead of the generic fallback glyph. `lsd` has no
      per-extension icon override mechanism (hardcoded in its source); `eza`
      supports one via `~/.config/eza/theme.yml`:
      ```yaml
      extensions:
        v:   { icon: { glyph: "<nerd-font glyph>" } }
        sv:  { icon: { glyph: "<nerd-font glyph>" } }
        cst: { icon: { glyph: "<nerd-font glyph>" } }
      ```
      Needs `eza` actually installed + tested before committing to the switch
      (not yet verified locally); update `l`/`la`/`ll` aliases in `.zshrc` if
      we go through with it.
