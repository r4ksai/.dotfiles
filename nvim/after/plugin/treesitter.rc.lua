local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "json",
    "yaml",
    "toml",
    "markdown",

    "tsx",
    "css",
    "html",

    "bash",
    "vim",
    "vimdoc",

    "lua",
    "python",

    "sql",
    "gitignore",
    "dockerfile",
    -- "dart",

    -- "cmake"
    "make",
    "arduino",
    "c",
    "cpp"
  },
  autotag = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

-- Extend tsx parsers filetypes
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
