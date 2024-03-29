require('ts_context_commentstring').setup {}

local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
  return
end

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = {
    "c",
    "cpp",
    "go",
    "javascript",
    "typescript",
    "graphql",
    "tsx",
    "rust",
    "json",
    "yaml",
    "toml",
    "lua",
    "dockerfile",
    "gitignore",
    "gomod",
    "java",
    "cmake",
    "make",
    "markdown",
    "markdown_inline",
    "bash",
    "python",
  },
  ignore_install = { "" }, -- List of parsers to ignore installing
  sync_install = true,     -- install languages synchronously (only applied to `ensure_installed`)
  highlight = {
    enable = true,         -- false will disable the whole extension
    disable = {},          -- list of language that will be disabled
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true }
})
