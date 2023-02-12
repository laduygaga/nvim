local Remap = require("duynn.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
-- local xnoremap = Remap.xnoremap
local tnoremap = Remap.tnoremap
-- local nmap = Remap.nmap


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
nnoremap("<leader><leader>h", "<cmd>Telescope help_tags<CR>", { silent = true })
nnoremap("<leader><leader>f", "<cmd>Files<CR>", { silent = true })
nnoremap("<leader>r", "<cmd>GRg<CR>", { silent = true })
nnoremap("<leader><leader>s", "<cmd>FRg<CR>", { silent = true })
nnoremap("<C-Tab>", "gt", { silent = true })
nnoremap("<S-Tab>", "gT", { silent = true })
nnoremap("gr", ":%s///g<left><left>", { silent = true })
nnoremap("g=", ":exe \"resize \" . (winheight(0) * 3/2)<CR>")
nnoremap("g-", ":exe \"resize \" . (winheight(0) * 2/3)<CR>")
nnoremap("gl", ":exe \"vertical resize \" . (winwidth(0) * 3/2)<CR>")
nnoremap("gL", ":exe \"vertical resize \" . (winwidth(0) * 2/3)<CR>")

vnoremap("<leader>,,", "<cmd>Trans :vi -b<CR>", { silent = true })
vnoremap("gd", "<cmd>\'<,\'>g/^$/d<CR>", { silent = true })
vnoremap("gD", "<cmd>g/^$/d<CR>", { silent = true })

vnoremap("g\"", "<esc>`>a\"<esc>`<i\"<esc>\"")
vnoremap("g\'", "<esc>`>a'<esc>`<i\'<esc>\'")
vnoremap("g)", "<esc>`>a)<esc>`<i(<esc>")
vnoremap("g}", "<esc>`>a}<esc>`<i{<esc>")
vnoremap("g]", "<esc>`>a]<esc>`<i[<esc>")

vnoremap("<C-j>", ":m '>+1<CR>gv=gv")
vnoremap("<C-k>", ":m '<-2<CR>gv=gv")

-- vnoremap("-", ":s/./&̶/g<CR>")
vnoremap("-", ":Strikethrough<CR>")
vnoremap("_", ":Underline<CR>")
vnoremap("=", ":DoubleUnderline<CR>")


nnoremap("<leader>g", "<cmd>Ag <C-r>=expand('<cword>')<CR><CR>", { silent = true })
nnoremap("<leader>s", "<cmd>AgFromSearch<CR>", { silent = true })
nnoremap("<leader>e", "<cmd>lua ToggleVExplorer()<CR>", { silent = true })
nnoremap("<leader>m", "<cmd>lua ToggleMouse()<CR>", { silent = true })
nnoremap("<leader>w", "<cmd>lua ToggleWrap()<CR>", { silent = true })
-- nnoremap("<C-e>", "<cmd>TagbarToggle<CR>", { silent = true })
nnoremap("<C-e>", "<cmd>AerialToggle!<CR>", { silent = true })
nnoremap("<leader>v", "<cmd>MarkdownPreviewToggle<CR>", { silent = true })
nnoremap("<F2>", "<cmd>lua ToggleExpandtab()<CR>", { silent = true })
nnoremap("<F4>", "<cmd>lua ToggleColorscheme()<CR>", { silent = true })

nnoremap("]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
nnoremap("[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
nnoremap("<C-j>", "<cmd>FloatermToggle<CR>", { silent = true })
tnoremap("<C-j>", "<C-\\><C-n>:FloatermToggle<CR>", { silent = true })
tnoremap("<C-]>", "<C-\\><C-n>", { silent = true })
nnoremap("<leader><leader>r", "<cmd>Lspsaga rename<CR>", { silent = true })
nnoremap("gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- source graph
nnoremap("<leader><space>", '<cmd>lua require("sg.telescope").fuzzy_search_results()<CR>', { silent = true })

-- scroll horizontally
nnoremap("<C-l>", "20zl", { silent = true })
nnoremap("<C-h>", "20zh", { silent = true })

-- cycle through breakpoints
nnoremap("]b", "<cmd> lua require('goto-breakpoints').next()<CR>", {silent=true})
nnoremap("[b", "<cmd> lua require('goto-breakpoints').prev()<CR>", {silent=true})

-- toggle chatgpt
nnoremap("<C-k>", "<cmd>ChatGPT<CR>", { silent = true })
