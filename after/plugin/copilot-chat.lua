local chat = require("CopilotChat")

chat.setup({
  model="gemini-2.5-pro",
  window = {
    temperature = 0.1,
    layout = 'float', -- 'vertical', 'horizontal', 'float', 'replace'
    width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
    height = 0.9, -- fractional height of parent, or absolute height in rows when > 1
    -- Options below only apply to floating windows
    relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
    border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
    row = nil, -- row position of the window, default is centered
    col = nil, -- column position of the window, default is centered
    title = 'Copilot Chat', -- title of chat window
    footer = nil, -- footer of chat window
    zindex = 1, -- determines if window is on top or below other floating windows
  },
})

-- this make nvim remember the last position of the chat window
vim.api.nvim_create_autocmd({"BufLeave", "BufWinLeave"}, {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "copilot-chat" then
      vim.cmd("silent! mkview")
    end
  end
})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "copilot-chat" then
      vim.cmd("silent! loadview")
    end
  end
})

