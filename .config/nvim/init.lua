vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

require("kakesu.globals")
require("kakesu.options")
require("kakesu.keymaps")

-- vim plugins with global settings inside have to be sourced before plugin
require("kakesu.quick-scope")
require("kakesu.maximizer")

require("kakesu.plugins")

