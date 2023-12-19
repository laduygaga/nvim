local vim = vim
local api = vim.api

local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_create_augroup(group_name, {})
        for _, def in ipairs(definition) do
            api.nvim_command("autocmd " .. group_name .. " " .. table.concat(def, " "))
        end
    end
end

local autocmds = {
    executor = {
        { "BufEnter", "*.py", "nnoremap <leader>2 :%w !python3<CR>" };
        { "BufEnter", "*.py", "vnoremap <leader>2 !python3<CR>" };
        { "BufEnter", "*.php", "nnoremap <leader>2 :%w !php<CR>" };
        { "BufEnter", "*.php", "vnoremap <leader>2 !php<CR>" };
        { "BufEnter", "*.sh", "nnoremap <leader>2 :%w !bash<CR>" };
        { "BufEnter", "*.sh", "vnoremap <leader>2 !bash<CR>" };
        { "BufEnter", "*.js", "nnoremap <leader>2 :%w !node<CR>" };
        { "BufEnter", "*.js", "vnoremap <leader>2 !node<CR>" };
        { "BufEnter", "*.pl", "nnoremap <leader>2 :%w !perl<CR>" };
        { "BufEnter", "*.pl", "vnoremap <leader>2 !perl<CR>" };
        { "BufEnter", "*.c", "nnoremap  <leader>2 :w<CR>:!clear;gcc -o %:r %:p<CR>:!./%:r<CR>" };
        { "BufEnter", "*.cpp", "nnoremap  <leader>2 :w<CR>:!clear;g++ -o %:r %:p<CR>:!./%:r<CR>" };
        { "BufEnter", "*.rs", "nnoremap	<leader>2 :w<CR>:!clear; rustc % <CR>:!./%:r<CR>" };
        { "BufEnter", "*.go", "nnoremap <leader>2 :w<CR>:%w !go run %<CR>" };
        { "BufEnter", "*.dart", "nnoremap <leader>2 :w<CR>:%w !dart %<CR>" };
        { "BufEnter", "*.lua", "nnoremap <leader>2 :w<CR>:%w !lua %<CR>" };
        { "BufEnter", "*.hs", "nnoremap  <leader>2 :w<CR>:!clear;ghc -dynamic %:p<CR>:!./%:r<CR>" };
	};
	bufleave = {
		{ "BufLeave", "*", [[call system("xsel -ib", getreg('+'))]] }; -- prevent loss of clipboard contents when leaving buffer
	};
	bufreadpost = {
		{ "BufReadPost", "*", [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]] }; -- restore place in file from previous session
		{ "BufReadPost", "quickfix", [[ nnoremap <buffer> <CR> <CR>]] };
	};
	python_debugger = {
		{ "BufEnter", "*.py", [[ vnoremap <silent> g// :norm 0i# <esc>]] };
		{ "BufEnter", "*.py", [[ vnoremap <silent> g/ :norm 0xx<esc>]] };
		{ "BufEnter", "*.py", [[nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>]] };
		{ "BufEnter", "*.py", [[nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR>]] };
		{ "BufEnter", "*.py", [[nnoremap <silent> <leader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]] };
		{ "BufEnter", "*.py", [[vnoremap <silent> <CR> :lua require("dapui").eval()<CR>]] };
		{ "BufEnter", "*.py", [[nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>]] };
		{ "BufEnter", "*.py", [[ nnoremap <silent> <leader>ds :lua require'dap'.close()<CR>]] };
		{ "BufEnter", "*.py", [[nnoremap <silent> <F8> :lua require'dap'.step_over()<CR>]] };
		{ "BufEnter", "*.py", [[nnoremap <silent> <F9> :lua require'dap'.step_into()<CR>]] };
		{ "BufEnter", "*.py", [[nnoremap <silent> <F10> :lua require'dap'.step_out()<CR>]] };
		{ "BufEnter", "*.py", [[nnoremap <silent> <leader>dr :lua require'dap'.repl.toggle()<CR>]] };
		{ "BufEnter", "*.py", [[nnoremap <silent> <leader>du :lua require("dapui").toggle()<CR>]] };
		{ "BufEnter", "*.py", [[nnoremap <silent> <leader>df :lua require('dap-python').test_method()<CR>]] };
		{ "BufEnter", "*.py", [[nnoremap <silent> <leader>do :lua require('dap-python').test_class()<CR>]] };
	};
	go_debugger = {
		{ "BufEnter", "*.go", [[ vnoremap <silent> g// :norm 0i// <esc>]] };
		{ "BufEnter", "*.go", [[ vnoremap <silent> g/ :norm 0xxx<esc>]] };
		{ "BufEnter", "*.go", [[ nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>]] };
		{ "BufEnter", "*.go", [[ nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR>]] };
		{ "BufEnter", "*.go", [[ nnoremap <silent> <leader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]] };
		{ "BufEnter", "*.go", [[ vnoremap <silent> <CR> :lua require("dapui").eval()<CR>]] };
		{ "BufEnter", "*.go", [[ nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>]] };
		{ "BufEnter", "*.go", [[ nnoremap <silent> <leader>ds :lua require'dap'.close()<CR>]] };
		{ "BufEnter", "*.go", [[ nnoremap <silent> <F8> :lua require'dap'.step_over()<CR>]] };
		{ "BufEnter", "*.go", [[ nnoremap <silent> <F9> :lua require'dap'.step_into()<CR>]] };
		{ "BufEnter", "*.go", [[ nnoremap <silent> <F10> :lua require'dap'.step_out()<CR>]] };
		{ "BufEnter", "*.go", [[ nnoremap <silent> <leader>dr :lua require'dap'.repl.toggle()<CR>]] };
		{ "BufEnter", "*.go", [[ nnoremap <silent> <leader>du :lua require("dapui").toggle()<CR>]] };
	};
	lua_debugger = {
		{ "BufEnter", "*.lua", [[ vnoremap <silent> g// :norm 0i-- <esc>]] };
		{ "BufEnter", "*.lua", [[ vnoremap <silent> g/ :norm 0xxx<esc>]] };
		{ "BufEnter", "*.lua", [[ nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR> ]]};
		{ "BufEnter", "*.lua", [[ nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR> ]]};
		{ "BufEnter", "*.lua", [[ nnoremap <silent> <leader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR> ]]};
		{ "BufEnter", "*.lua", [[ vnoremap <silent> <CR> :lua require("dapui").eval()<CR> ]]};
		{ "BufEnter", "*.lua", [[ nnoremap <silent> <F5> :lua require"osv".run_this()<CR> ]]};
		{ "BufEnter", "*.lua", [[ nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR> ]]};
		{ "BufEnter", "*.lua", [[ nnoremap <silent> <leader>ds :lua require'dap'.close()<CR>]] };
		{ "BufEnter", "*.lua", [[ nnoremap <silent> <F8> :lua require'dap'.step_over()<CR> ]]};
		{ "BufEnter", "*.lua", [[ nnoremap <silent> <F9> :lua require'dap'.step_into()<CR> ]]};
		{ "BufEnter", "*.lua", [[ nnoremap <silent> <F10> :lua require'dap'.step_out()<CR> ]]};
		{ "BufEnter", "*.lua", [[ nnoremap <silent> <leader>dr :lua require'dap'.repl.toggle()<CR> ]]};
		{ "BufEnter", "*.lua", [[ nnoremap <silent> <leader>du :lua require("dapui").toggle()<CR> ]]};
	};
	dart = {
		-- use spaces instead of tabs
		{ "BufEnter", "*.dart", [[ setlocal tabstop=2 shiftwidth=2 expandtab ]]};
	};
	html = {
		{ "BufEnter", "*.html", [[ vnoremap <leader>f :call FormatAndIndentHTML()<cr> ]]};
	};
	gohtml = {
		-- set syntax=html when enter gohtml file
		{ "BufEnter", "*.gohtml", [[ setlocal syntax=html ]]};
	};
	floatterm = {
		-- floattermupdate when resize window
		{ "VimResized", "*", [[ FloatermUpdate ]] };
	};
	misc = {
		{ "BufNewFile,BufRead", "*.conf", [[setf dosini]]};
	};
}

nvim_create_augroups(autocmds)
