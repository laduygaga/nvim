-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Simple plugins can be specified as strings
  use  'hrsh7th/cmp-nvim-lsp'
  use  'hrsh7th/cmp-buffer'
  use  'hrsh7th/cmp-path'
  use  'hrsh7th/cmp-cmdline'
  use  'hrsh7th/nvim-cmp'
  use  'saadparwaiz1/cmp_luasnip'
  use  'L3MON4D3/LuaSnip'


  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'voldikss/vim-floaterm'
  use 'rhysd/git-messenger.vim'
  use 'will133/vim-dirdiff'
  use 'joshdick/onedark.vim'
  use 'airblade/vim-gitgutter'
  use 'majutsushi/tagbar'
  use 'mattn/emmet-vim' -- <C-y>,
  use 'tpope/vim-surround'
  use 'echuraev/translate-shell.vim'
  use 'junegunn/fzf.vim'
  use 'ggreer/the_silver_searcher'
  use 'pamacs/vim-srt-sync'
  use 'rking/ag.vim'
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'
  use 'leoluz/nvim-dap-go'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'rcarriga/nvim-dap-ui'
  use 'jbyuki/one-small-step-for-vimkind'
  use 'neovim/nvim-lspconfig'
  -- use 'github/copilot.vim'
  use 'tami5/lspsaga.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'jmerle/competitive-companion'
  use 'p00f/cphelper.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'folke/lsp-colors.nvim'



  -- Plugins can have post-install/update hooks
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })


  -- Post-install/update hook with neovim command
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  -- Post-install/update hook with call of vimscript function with argument
  use { "junegunn/fzf", run = ":call fzf#install()" }


  -- Use specific branch, dependency and run lua file after load
  -- use { 'ms-jpq/coq_nvim', branch = 'coq' }
  -- use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
  -- use { 'ms-jpq/coq.thirdparty', branch = '3p' }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
