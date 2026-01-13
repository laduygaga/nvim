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
  -- 2. Internal FZF behavior (Input at bottom)
  fzf_opts = {
    ['--layout'] = 'default', -- results grow UP from the bottom input
  },
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
