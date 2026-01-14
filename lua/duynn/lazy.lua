-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Core
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-lua/popup.nvim", lazy = true },
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- LSP & Completion
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "folke/lsp-colors.nvim" },
  },
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    build = "make install_jsregexp",
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/playground" },
  },

  -- Fuzzy Finder
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('fzf-lua').setup({})
    end,
  },

  -- Git
  {
    "tpope/vim-fugitive",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit" },
  },
  { "tpope/vim-rhubarb", lazy = true },
  {
    "airblade/vim-gitgutter",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "rhysd/git-messenger.vim",
    cmd = "GitMessenger",
    keys = { { "<leader>gm", "<cmd>GitMessenger<cr>", desc = "Git messenger" } },
  },
  { "will133/vim-dirdiff", cmd = "DirDiff" },

  -- DAP (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>ds", function() require("dap").close() end, desc = "Stop" },
    },
    dependencies = {
      { "theHamsta/nvim-dap-virtual-text", config = true },
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" }, config = true },
      { "ofirgall/goto-breakpoints.nvim" },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    dependencies = { "mfussenegger/nvim-dap" },
  },
  {
    "jbyuki/one-small-step-for-vimkind",
    ft = "lua",
    dependencies = { "mfussenegger/nvim-dap" },
  },

  -- Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = { "CopilotChat", "CopilotChatOpen", "CopilotChatToggle" },
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("CopilotChat").setup({})
    end,
  },

  -- UI & Navigation
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent directory" } },
    config = function()
      require("oil").setup()
    end,
  },
  {
    "stevearc/aerial.nvim",
    cmd = "AerialToggle",
    keys = { { "<leader>a", "<cmd>AerialToggle<cr>", desc = "Aerial" } },
    config = function()
      require("aerial").setup()
    end,
  },
  {
    "majutsushi/tagbar",
    cmd = "TagbarToggle",
    keys = { { "<F8>", "<cmd>TagbarToggle<cr>", desc = "Tagbar" } },
  },

  -- Terminal
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermToggle" },
    keys = {
      { "<leader>t", "<cmd>FloatermToggle<cr>", desc = "Toggle terminal" },
    },
  },

  -- Editing
  { "tpope/vim-surround", event = "VeryLazy" },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" } },
      { "gb", mode = { "n", "v" } },
    },
    config = function()
      require("Comment").setup()
    end,
  },
  { "mattn/emmet-vim", ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" } },

  -- Orgmode
  {
    "nvim-orgmode/orgmode",
    ft = "org",
    config = function()
      require("orgmode").setup({})
    end,
  },

  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = ":call mkdp#util#install()",
  },

  -- Languages
  { "TovarishFin/vim-solidity", ft = "solidity" },
  { "ggreer/the_silver_searcher", lazy = true },
  { "rking/ag.vim", cmd = "Ag" },
  { "echuraev/translate-shell.vim", cmd = "Trans" },
  { "pamacs/vim-srt-sync", ft = "srt" },

  -- Competitive Programming
  { "jmerle/competitive-companion", ft = "cpp" },
  { "p00f/cphelper.nvim", ft = "cpp" },

  -- Colorscheme
  {
    "joshdick/onedark.vim",
    lazy = false,
    priority = 1000,
  },
  { "folke/lsp-colors.nvim", lazy = true },
}, {
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
