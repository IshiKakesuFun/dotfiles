local status, configs --, parsers
--------------------------------------------------------------------------------
-- https://github.com/nvim-treesitter/nvim-treesitter
--------------------------------------------------------------------------------
-- import plugin safely
status, configs = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

-- import plugin safely
-- status, parsers = pcall(require, "nvim-treesitter.parsers")
-- if not status then
--   return
-- end

configs.setup({
  -- A list of parser names, or "all"
  ensure_installed = {
    -- "bash",
    -- "c",
    -- "c_sharp",
    -- "clojure",
    -- "cmake",
    -- "css",
    -- "dockerfile",
    -- "gitignore",
    -- "go",
    -- "graphql",
    -- "html",
    -- "java",
    -- "javascript",
    -- "json",
    "lua",
    -- "mermaid",
    "markdown",
    -- "prisma",
    -- "python",
    -- "regex",
    -- "scss",
    -- "toml",
    -- "tsx",
    -- "typescript",
    -- "vim",
    -- "vue",
    -- "yaml",
  },
  highlight = {
    enable = true,
    disable = {},
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- enable indentation
  indent = {
    enable = true,
    disable = {},
  },

  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = {
    enable = true,
  },
})

-- local parser_configs = parsers.get_parser_configs()
-- parser_configs.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
