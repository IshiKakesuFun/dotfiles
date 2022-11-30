--------------------------------------------------------------------------------
-- https://github.com/wbthomason/packer.nvim
--------------------------------------------------------------------------------
local status, u, packer -- {{{
-- import ustils safely
status, u = pcall(require, "kakesu.utils")
if not status then
  print("Utilities are not installed")
  return
end -- }}}

--{{{ auto install packer if not installed
local packerUrl = "https://github.com/wbthomason/packer.nvim"
local install_path = u.concat_path(DATA_PATH, "site", "pack", "packer", "start", "packer.nvim")

local ensure_packer = function()
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ "git", "clone", "--depth", "1", packerUrl, install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
local group = vim.api.nvim_create_augroup("PackerUserConfig", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = "plugins.lua",
  command = "source <afile> | PackerSync",
})

-- import packer safely
status, packer = pcall(require, "packer")
if not status then
  print("Packer is not installed")
  return
end -- }}}

-- add list of plugins to install
return packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")

  use("nvim-lua/plenary.nvim") -- collection of lua functions that many plugins use
  use({
    "nvim-lua/popup.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  --{{{ color scheme
  use("ellisonleao/gruvbox.nvim")
  use("EdenEast/nightfox.nvim")
  use("arcticicestudio/nord-vim")
  --}}}

  --{{{ essential plugins
  -- add, delete, change surroundings (it's awesome)
  use("tpope/vim-surround")
  -- commenting with gc, gb
  use("numToStr/Comment.nvim")
  -- quick scope navigation
  use("unblevable/quick-scope")
  -- window maximizer
  use("szw/vim-maximizer")
  -- symlinks resolver makes vim-fugitive behave properly with linked files
  -- use({
  --   "aymericbeaumet/vim-symlink",
  --   requires = { "moll/vim-bbye" },
  -- })
  --}}}

  -- git
  use("tpope/vim-fugitive")
  use("lewis6991/gitsigns.nvim")
  --
  -- vs-code like icons
  use("nvim-tree/nvim-web-devicons")

  -- statusline
  use("nvim-lualine/lualine.nvim")

  -- buffer/tab line
  -- use({
  --   "akinsho/bufferline.nvim",
  --   tag = "v3.*",
  --   requires = "nvim-tree/nvim-web-devicons",
  -- })

  --[[
  -- File/project explorer
  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
  })
  ]]
  -- treesitter configuration
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  })
  -- Telescope
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  })
  use({
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })
  use("nvim-telescope/telescope-file-browser.nvim")

  -- autocompletion
  use("hrsh7th/nvim-cmp") -- completion plugin
  use("hrsh7th/cmp-buffer") -- nvim-cmp source for text in buffer
  use("hrsh7th/cmp-path") -- source for file system paths
  -- snippets
  use("L3MON4D3/LuaSnip") -- snippet engine
  use("saadparwaiz1/cmp_luasnip") -- for autocompletion
  --[[
  use("rafamadriz/friendly-snippets") -- useful snippets

  -- managing and installing LSP servers, linters and formaters
  use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
  use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig
  ]]

  -- configuration of LSP servers
  use("neovim/nvim-lspconfig") -- easily configure language servers
  use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for built-in LSP
  --[[
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
  })

  -- enhanced lsp uis
  use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
  ]]
  use("onsails/lspkind.nvim") -- vs-code like icons or pictograms for autocompletion
  --[[
  -- formatting & linting
  use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
  use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls
  ]]
  -- Tools
  use("folke/zen-mode.nvim")
  use("norcalli/nvim-colorizer.lua")
  use("windwp/nvim-autopairs")
  use("windwp/nvim-ts-autotag")

  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })

  use({
    "akinsho/toggleterm.nvim",
    tag = '*',
  })


  if packer_bootstrap then
    require("packer").sync()
  end
end)
