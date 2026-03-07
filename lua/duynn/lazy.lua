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
    lazy = false,
    priority = 1000,
    build = ":TSUpdate",
    config = function()
      local treesitter = require('nvim-treesitter')
      treesitter.setup({
        ensure_installed = {
          "tsx", "toml", "fish", "php", "json", "yaml", "swift", "html", "scss",
          "python", "c", "cpp", "go", "bash", "lua", "rust", "typescript", "javascript",
          "vue", "proto", "regex", "latex", "markdown", "perl", "haskell", "ruby",
          "graphql", "cmake", "vim", "dockerfile", "dart", "vimdoc", "query", "diff",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local file = vim.api.nvim_buf_get_name(buf)
            if file:match("%.pb%.go$") then
              return false
            end
            if vim.api.nvim_buf_line_count(buf) > 10000 then
              return true
            end
            if lang == "html" or lang == "javascript" then
              local lines = vim.api.nvim_buf_get_lines(buf, 0, 100, false)
              for _, line in ipairs(lines) do
                if #line > 300 then
                  return true
                end
              end
            end
            return false
          end,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = false
        },
      })
      
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if ft == "" or ft == "checkhealth" or ft:match("fzf") or ft:match("Telescope") then return end
          
          pcall(function()
            local ts = require("nvim-treesitter")
            local installed = ts.get_installed()
            local is_installed = false
            for _, p in ipairs(installed) do
              if p == ft then is_installed = true break end
            end
            
            if not is_installed then
              local parsers = require("nvim-treesitter.parsers")
              if parsers[ft] then
                -- Use async TSInstall to avoid hanging the UI
                vim.notify("Installing treesitter parser for " .. ft .. "...")
                vim.cmd("TSInstall " .. ft)
                
                -- Wait for install to finish then start highlighting
                -- We check every 2 seconds for up to 20 seconds
                local timer = vim.loop.new_timer()
                local count = 0
                timer:start(2000, 2000, vim.schedule_wrap(function()
                  count = count + 1
                  local currently_installed = ts.get_installed()
                  local found = false
                  for _, p in ipairs(currently_installed) do
                    if p == ft then found = true break end
                  end
                  
                  if found or count > 10 then
                    pcall(vim.treesitter.start, args.buf, ft)
                    timer:stop()
                    timer:close()
                  end
                end))
              end
            else
              -- Force start highlighting for already installed languages
              pcall(vim.treesitter.start, args.buf, ft)
            end
          end)
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
    cmd = { "AerialToggle", "AerialOpen", "AerialClose", "AerialInfo" },
    keys = { { "<leader>a", "<cmd>AerialToggle<cr>", desc = "Aerial" } },
    config = function()
      require("duynn.config.aerial")
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
