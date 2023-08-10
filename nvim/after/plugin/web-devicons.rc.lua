local status, icons = pcall(require, "nvim-web-devicons")
if (not status) then return end

icons.setup {
  -- your personnal icons can go here (to override)
  -- DevIcon will be appended to `name`
  override = {
  },

  override_by_filename = {
    [".gitignore"] = {
      icon = "",
      color = "#f1502f",
      name = "Gitignore"
    },
    [".settings.json"] = {
      icon = "",
      color = "#854CC7",
      cterm_color = "98",
      name = "SettingsJson",
    },
    [".inputrc"] = {
      icon = "",
      color = "#89e051",
      cterm_color = "113",
      name = "Inputrc",
    },
    [".zprofile"] = {
      icon = "",
      color = "#89e051",
      cterm_color = "113",
      name = "Zshprofile",
    },
    [".zshenv"] = {
      icon = "",
      color = "#89e051",
      cterm_color = "113",
      name = "Zshenv",
    },
    ["yarn.lock"] = {
      icon = "",
      color = "#0288d1",
      cterm_color = "32",
      name = "YarnLock",
    },
    ["yarn-error.log"] = {
      icon = "",
      color = "#0288d1",
      cterm_color = "32",
      name = "YarnError",
    },
    [".prettierrc.json"] = {
      icon = "",
      color = "#ea5e5e",
      cterm_color = "167",
      name = "Prettier",
    },
    [".prettierrc.yml"] = {
      icon = "",
      color = "#ea5e5e",
      cterm_color = "167",
      name = "Prettier",
    },
    [".prettierrc.yaml"] = {
      icon = "",
      color = "#ea5e5e",
      cterm_color = "167",
      name = "Prettier",
    },
    [".prettierrc.js"] = {
      icon = "",
      color = "#ea5e5e",
      cterm_color = "167",
      name = "Prettier",
    },
    [".prettierrc.toml"] = {
      icon = "",
      color = "#ea5e5e",
      cterm_color = "167",
      name = "Prettier",
    },
    ["CMakeLists.txt"] = {
      icon = "",
      color = "#6d8086",
      cterm_color = "66",
      name = "CMakeLists",
    },
    ["COMMIT_EDITMSG"] = {
      icon = "",
      color = "#41535b",
      cterm_color = "239",
      name = "GitCommit",
    },
    ["COPYING"] = {
      icon = "",
      color = "#cbcb41",
      cterm_color = "185",
      name = "License",
    },
    ["COPYING.LESSER"] = {
      icon = "",
      color = "#cbcb41",
      cterm_color = "185",
      name = "License",
    },
    ["robots.txt"] = {
      icon = "ﮧ",
      color = "#ff5252",
      cterm_color = "203",
      name = "Robots",
    },
    ["robot"] = {
      icon = "ﮧ",
      color = "#00bfa5",
      cterm_color = "37",
      name = "Robot",
    },
    ["CONTRIBUTING.md"] = {
      icon = "",
      color = "#ffca28",
      cterm_color = "220",
      name = "CONTRIBUTING.md",
    },
    ["README.md"] = {
      icon = "",
      color = "#42a5f5",
      cterm_color = "75",
      name = "README.md",
    },
    [".svgrrc"] = {
      icon = "ﰆ",
      color = "#ffb300",
      cterm_color = "214",
      name = "Svgrrc",
    },
    ["vite.config.js"] = {
      icon = "",
      color = "#ffab00",
      cterm_color = "214",
      name = "vite.config.js",
    },
    ["nuxt.config.js"] = {
      icon = "行",
      color = "#00e676",
      cterm_color = "42",
      name = "nuxt.config.js",
    },
  },


  override_by_extension = {
    ["ttf"] = {
      icon = "",
      color = "#f44336",
      cterm_color = "203",
      name = "Ttf",
    },
    ["woff"] = {
      icon = "",
      color = "#f44336",
      cterm_color = "203",
      name = "WebOpenFontFormat",
    },
    ["woff2"] = {
      icon = "",
      color = "#f44336",
      cterm_color = "203",
      name = "WebOpenFontFormat",
    },
    ["mp3"] = {
      icon = "",
      color = "#f44336",
      cterm_color = "203",
      name = "Mp3",
    },
    ["wav"] = {
      icon = "",
      color = "#f44336",
      cterm_color = "203",
      name = "Wav",
    },
    ["mp4"] = {
      icon = "",
      color = "#ff9800",
      cterm_color = "208",
      name = "Mp4",
    },
    ["tif"] = {
      icon = "",
      color = "#26a69a",
      cterm_color = "36",
      name = "Tif",
    },
    ["tiff"] = {
      icon = "",
      color = "#26a69a",
      cterm_color = "36",
      name = "Tiff",
    },
    ["log"] = {
      icon = "",
      color = "#81e043",
      name = "Log"
    },
    ["blend"] = {
      icon = "󰂫",
      color = "#EA7600",
      name = "Blender"
    },
    ["diff"] = {
      icon = "",
      color = "#41535b",
      cterm_color = "239",
      name = "Diff",
    },
    ["doc"] = {
      icon = "",
      color = "#185abd",
      cterm_color = "25",
      name = "Doc",
    },
    ["gif"] = {
      icon = "",
      color = "#26a69a",
      cterm_color = "36",
      name = "Gif",
    },
    ["rar"] = {
      icon = "遲",
      color = "#afb42b",
      cterm_color = "142",
      name = "Rar",
    },
    ["zip"] = {
      icon = "",
      color = "#afb42b",
      cterm_color = "142",
      name = "Zip",
    },
    ["xz"] = {
      icon = "",
      color = "#afb42b",
      cterm_color = "142",
      name = "Xz",
    },
    ["hex"] = {
      icon = "",
      color = "#26a69a",
      cterm_color = "36",
      name = "Hex",
    },
    ["bin"] = {
      icon = "",
      color = "#26a69a",
      cterm_color = "36",
      name = "Bin",
    },
    ["dat"] = {
      icon = "",
      color = "#26a69a",
      cterm_color = "36",
      name = "Dat",
    },
    ["asm"] = {
      icon = "ﬧ",
      color = "#ff6e40",
      cterm_color = "203",
      name = "Asm",
    },
    ["ino"] = {
      icon = "ﯢ",
      color = "#00979c",
      cterm_color = "31",
      name = "Arduino",
    },
    ["obj"] = {
      icon = "",
      color = "#29b6f6",
      cterm_color = "39",
      name = "Obj",
    },
    ["fbx"] = {
      icon = "",
      color = "#29b6f6",
      cterm_color = "39",
      name = "Fbx",
    },
    ["lock"] = {
      icon = "",
      color = "#ffd54f",
      cterm_color = "221",
      name = "Lock",
    },
    ["cjs"] = {
      icon = "",
      color = "#ffca28",
      cterm_color = "220",
      name = "TestJavascript",
    },
    ["test.js"] = {
      icon = "󰙨",
      color = "#ffca28",
      cterm_color = "220",
      name = "TestJavascript",
    },
    ["test.jsx"] = {
      icon = "󰙨",
      color = "#00bcd4",
      cterm_color = "38",
      name = "TestJavascriptReact",
    },
    ["test.ts"] = {
      icon = "󰙨",
      color = "#00bcd4",
      cterm_color = "38",
      name = "TestTypescript",
    },
  },

  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  color_icons = true,
  default = true
}
