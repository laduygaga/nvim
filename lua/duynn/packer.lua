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

  use 'mason-org/mason.nvim'
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
  use 'mxsdev/nvim-dap-vscode-js'
  -- use {
  --   "microsoft/vscode-js-debug",
  --   opt = true,
  --   run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  -- }
  use 'theHamsta/nvim-dap-virtual-text'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
  use 'jbyuki/one-small-step-for-vimkind'
  use 'github/copilot.vim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'jmerle/competitive-companion'
  use 'p00f/cphelper.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'folke/lsp-colors.nvim'
  use({
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
    end,
  })

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

  use {
    'stevearc/aerial.nvim',
    config = function() require('aerial').setup() end
  }
  use 'ofirgall/goto-breakpoints.nvim'
  use {'nvim-orgmode/orgmode', config = function()
    require('orgmode').setup{}
  end
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }
  use {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    requires = {
      -- { 'zbirenbaum/copilot.lua' },
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim' }
    },
    config = function()
      require('CopilotChat').setup({
        debug = true, -- Enable debugging
        -- See Configuration section for rest
      })
    end
    -- See Commands section for default commands if you want to lazy load on them
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
