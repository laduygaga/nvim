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
    priority = 100, -- Load before other BufReadPre handlers
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = function()
      pcall(vim.cmd, "MasonUpdate")
    end,
    config = function()
      require("mason").setup()
    end,
  },
  -- Completion: blink.cmp (replaces hrsh7th/nvim-cmp)
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = { "L3MON4D3/LuaSnip" },
    opts = {
      keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<C-Space>"] = { "show" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },
      completion = {
        documentation = { auto_show = true },
        menu = {
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "source_name", gap = 1 },
              { "kind_icon", "kind" },
            },
            components = {
              source_name = {
                text = function(ctx)
                  return "[" .. ctx.source_name .. "]"
                end,
                highlight = "BlinkCmpSource",
              },
            },
          },
        },
      },
      signature = { enabled = true },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
          org = { inherit_defaults = true, "orgmode" },
        },
        providers = {
          lsp = { name = "LSP", module = "blink.cmp.sources.lsp" },
          path = { name = "Path", module = "blink.cmp.sources.path" },
          buffer = { name = "Buffer", module = "blink.cmp.sources.buffer" },
          snippets = { name = "LuaSnip", module = "blink.cmp.sources.snippets" },
          lazydev = {
            name = "Lua",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          orgmode = {
            name = "Orgmode",
            module = "blink.compat.source",
            -- orgmode registers its cmp source as "orgmode"
            opts = { cmp_name = "orgmode" },
          },
        },
      },
    },
  },
  -- Provides a `cmp` shim so nvim-cmp-only sources (e.g. orgmode) register
  -- with blink. Loaded explicitly at startup in lua/duynn/lazy.lua (right
  -- after lazy.setup) so the shim is on the rtp before any file opens and
  -- orgmode's cmp source can call require('cmp'). Do NOT make this a
  -- dependency of blink.cmp: it would inherit InsertEnter and load too late.
  {
    "saghen/blink.compat",
    version = "2.*",
    opts = {},
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    priority = 1000,
    build = ":TSUpdate",
    config = function()
      local treesitter = require('nvim-treesitter')
      treesitter.setup({
        ensure_installed = {
          "go", "python", "lua", "yaml", "json", "cmake", "toml", "bash", "html",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true
        },
      })
      
      -- Enable treesitter for the current buffer
      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  -- Fuzzy Finder
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "gd", "<cmd>FzfLua lsp_definitions<cr>", desc = "LSP Definitions" },
      { "gi", "<cmd>FzfLua lsp_implementations<cr>", desc = "LSP Implementations" },
      { "gh", "<cmd>FzfLua lsp_references<cr>", desc = "LSP References" },
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
    cmd = { "AerialToggle", "AerialOpen", "AerialClose", "AerialInfo" },
    keys = { { "<leader>a", "<cmd>AerialToggle<cr>", desc = "Aerial" } },
    config = function()
      require("duynn.config.aerial")
    end,
  },

  -- Terminal
  {
    "voldikss/vim-floaterm",
    cmd = { "FloatermNew", "FloatermToggle" },
    keys = {
      -- { "<leader>t", "<cmd>FloatermToggle<cr>", desc = "Toggle terminal" },
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

  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = ":call mkdp#util#install()",
  },

  -- Languages
  { "TovarishFin/vim-solidity", ft = "solidity" },
  { "ggreer/the_silver_searcher", lazy = true },
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
  {
    "laduygaga/csvview.nvim",
    branch = "fix/multi-line-sticky-header",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
        view = {
        -- Set to true for auto-detection (default)
        -- Or set to a number (e.g., 1) to force a specific line
        header_lnum = 5,
        sticky_header = {
          enabled = true,
          separator = "─", -- Character used for the line below the sticky header
        },
      },
      parser = { comments = { "#", "//" } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  }
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

-- Load blink.compat at startup so its `cmp` shim is on the rtp before any
-- file opens. nvim-cmp-only sources (e.g. orgmode) call require('cmp')
-- during their own setup, which runs at BufRead (before InsertEnter), so the
-- shim must already be available here or those sources silently fail to register.
pcall(require, "blink.compat")
