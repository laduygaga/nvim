--  always show the status bar
vim.opt.laststatus=2
vim.opt.statusline = ''
vim.opt.title = true
vim.opt.titlestring = '%f - %w'

-- windows
-- vim.opt.winheight = 25
-- vim.opt.winwidth = 80

vim.opt.splitbelow = true

-- folding
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel= 99

-- turn on line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- encoding
vim.opt.fileformat = 'unix'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = "ucs-bom,utf-8,gbk,gb18030,big5,cp936,latin1"

-- sane editing
-- setlocal noexpandtab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.colorcolumn = '80'
vim.opt.viminfo="'25,\"50,n/tmp/.viminfo"
vim.opt.autoread = true

-- mouse
vim.opt.mouse = ''

-- latency
vim.opt.timeoutlen = 400

vim.opt.scrolloff = 999
vim.opt.cmdheight = 2
vim.opt.smartcase = true
vim.opt.ignorecase = true
-- vim.opt.path:append({ '**' })
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.nrformats:remove{"octal"}
vim.opt.cursorline = true
vim.opt.wrap = true

vim.keymap.set('n', '<leader>dt', function()
    local timestamp = vim.fn.expand('<cword>')
    -- Basic check to see if the word is a number
    if tonumber(timestamp) then
        local date = os.date('%Y-%m-%d %H:%M:%S', timestamp)
        print("Date: " .. date)
    else
        print("Error: Word under cursor is not a valid timestamp.")
    end
end, { desc = "Preview timestamp as date" })
