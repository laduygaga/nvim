local Remap = require("duynn.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local tnoremap = Remap.tnoremap
local nmap = Remap.nmap


inoremap("jk", "<ESC>")
nnoremap("'", "`")
-- git-message
nnoremap("<CR>", "<cmd>GitMessenger<CR>")
vnoremap("Y", "\"+y")
vnoremap("*", "y<ESC>/<C-r>\"<CR>")
nnoremap("<leader>t", "<cmd>tabnew<CR>", { silent = true })
nnoremap("<leader><leader>d", "<cmd>tabclose<CR>", { silent = true })
nnoremap("<leader><leader>D", "<cmd>qa!<CR>", { silent = true })
nnoremap("<leader><leader>g", "<cmd>GFiles<CR>", { silent = true })
nnoremap("<leader><leader>f", "<cmd>Files<CR>", { silent = true })
nnoremap("<leader>r", "<cmd>GRg<CR>", { silent = true })
nnoremap("<leader><leader>s", "<cmd>FRg<CR>", { silent = true })
nnoremap("<C-Tab>", "gt", { silent = true })
nnoremap("<S-Tab>", "gT", { silent = true })

vnoremap("<leader>,,", "<cmd>Trans :vi -b<CR>", { silent = true })

nnoremap("<leader>g", "<cmd>Ag <C-r>=expand('<cword>')<CR><CR>", { silent = true })
nnoremap("<leader>s", "<cmd>AgFromSearch<CR>", { silent = true })
nnoremap("<leader>e", "<cmd>call ToggleVExplorer()<CR>", { silent = true })
nnoremap("<leader>m", "<cmd>lua ToggleMouse()<CR>", { silent = true })
nnoremap("<leader>w", "<cmd>lua ToggleWrap()<CR>", { silent = true })
nnoremap("<leader>T", "<cmd>TagbarToggle<CR>", { silent = true })
nnoremap("<leader>v", "<cmd>MarkdownPreviewToggle<CR>", { silent = true })
nnoremap("<leader>y", "<cmd>let @\" = expand(\"%:p\")<CR>", { silent = true })
nnoremap("<F2>", "<cmd>call ToggleExpandTab()<CR>", { silent = true })
nnoremap("<F4>", "<cmd>lua ToggleColorscheme()<CR>", { silent = true })

nnoremap("]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
nnoremap("]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
nnoremap("<C-j>", "<cmd>FloatermToggle<CR>", { silent = true })
tnoremap("<C-j>", "<C-\\><C-n>:FloatermToggle<CR>", { silent = true })
nnoremap("<leader><leader>r", "<cmd>Lspsaga rename<CR>", { silent = true })
nnoremap("gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- dap debuger
