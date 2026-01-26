local fzf = require('fzf-lua')

require('fzf-lua').setup({
  -- 1. Window layout (Floating)
  winopts = {
    height     = 0.85,      -- window height (85% of screen)
    width      = 0.80,      -- window width (80% of screen)
    row        = 0.35,      -- vertical position
    col        = 0.50,      -- horizontal position
    border     = 'rounded', -- options: 'single', 'double', 'rounded', 'none'
    preview = {
      layout = 'horizontal',  -- preview on top, list on bottom
      horizontal = 'right:60%',    -- preview on left, list on right
    },
  },
  previewers = {
    builtin = {
      -- This allows the builtin previewer to handle images
      extensions = {
        ["png"] = { "ueberzug", "{file}" },
        ["jpg"] = { "ueberzug", "{file}" },
        ["jpeg"] = { "ueberzug", "{file}" },
        ["gif"] = { "ueberzug", "{file}" },
      },
    },
  },
  -- 2. Internal FZF behavior (Input at bottom)
  fzf_opts = {
    ['--layout'] = 'default', -- results grow UP from the bottom input
  },
  files = {
    -- 1. Added --no-ignore to see .env even if it's in .gitignore
    -- 2. Kept --hidden to see files starting with a dot
    cmd = "fd --type f --hidden --no-ignore --follow --exclude .git",
  }
})
-- Alternative to GRg (Search from Git Root)
vim.keymap.set('n', '<leader>r', function()
  -- Automatically finds the directory containing .git
  local root = vim.fs.root(0, ".git")
  fzf.live_grep({ cwd = root })
end, { desc = "Fzf Live Grep (Git Root)" })

-- Alternative to FRg (Search from Current Directory)
vim.keymap.set('n', '<leader><leader>s', function()
  fzf.live_grep({ cwd = vim.fn.getcwd() })
end, { desc = "Fzf Live Grep (CWD)" })


-- Search all files in CWD (What :Files used to do)
vim.keymap.set('n', '<leader><leader>f', fzf.files, { desc = "Fzf Files" })

-- Search only files tracked by Git (Very fast)
vim.keymap.set('n', '<leader><leader>g', fzf.git_files, { desc = "Fzf Git Files" })

-- Search recently opened files (OldFiles)
vim.keymap.set('n', '<leader>fo', fzf.oldfiles, { desc = "Fzf Recent Files" })
