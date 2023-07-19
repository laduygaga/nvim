-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
  use({
    "jackMort/ChatGPT.nvim",
      config = function()
        require("chatgpt").setup()
      end,
      requires = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
      }
  })
  -- nvim inside chrome
  -- use {
  --     'glacambre/firenvim',
  --     run = function() vim.fn['firenvim#install'](0) end 
  -- }
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Simple plugins can be specified as strings
  use  'hrsh7th/cmp-nvim-lsp'
  use  'hrsh7th/cmp-buffer'
  use  'hrsh7th/cmp-path'
  use  'hrsh7th/cmp-cmdline'
  use  'hrsh7th/nvim-cmp'
  use  'saadparwaiz1/cmp_luasnip'
  use { "L3MON4D3/LuaSnip", run = "make install_jsregexp" }


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
  use 'github/copilot.vim'
  use 'tami5/lspsaga.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'jmerle/competitive-companion'
  use 'p00f/cphelper.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'folke/lsp-colors.nvim'



  -- Plugins can have post-install/update hooks
  use({ "iamcco/markdown-preview.nvim", run = ":call mkdp#util#install()", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })


  -- Post-install/update hook with neovim command
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use('nvim-treesitter/playground')

  -- Post-install/update hook with call of vimscript function with argument
  use { "junegunn/fzf", run = ":call fzf#install()" }


  -- Use specific branch, dependency and run lua file after load
  -- use { 'ms-jpq/coq_nvim', branch = 'coq' }
  -- use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
  -- use { 'ms-jpq/coq.thirdparty', branch = '3p' }
  use { 'sourcegraph/sg.nvim', run = 'nvim -l build/init.lua' }
  use {
    'stevearc/aerial.nvim',
    config = function() require('aerial').setup() end
  }
  use 'ofirgall/goto-breakpoints.nvim'
  use {'nvim-treesitter/nvim-treesitter'}
  use {'nvim-orgmode/orgmode', config = function()
    require('orgmode').setup{}
  end
  }
  use {  'TobinPalmer/pastify.nvim', -- requie pms python-neovim python pillow
  cmd = { 'Pastify' },
  config = function()
    require('pastify').setup {
	  opts = {
		absolute_path = false, -- use absolute or relative path to the working directory
        apikey = "1cac60eaeb1877f098ead335054f6b68 (https://api.imgbb.com/)", -- Needed if you want to save online.
		local_path = '/assets/imgs/', -- The path to put local files in, ex ~/Projects/<name>/assets/images/<imgname>.png
		save = 'local', -- Either 'local' or 'online'
	  },
    }
  end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
