local osv_chan

local function debug_file()
  local dap = require("dap")
  
  -- 1. Cleanup
  if dap.session() then
    dap.terminate()
  end
  if osv_chan then
    pcall(vim.fn.jobstop, osv_chan)
    osv_chan = nil
  end
  
  local filename = vim.fn.expand('%:p')
  local rtp = vim.o.runtimepath
  local pp = vim.o.packpath
  
  -- 2. Start headless Neovim
  osv_chan = vim.fn.jobstart({vim.v.progpath, '-u', 'NONE', '--headless', '--embed'}, { rpc = true })
  
  -- 3. Run blocking debugger in headless instance
  -- This will wait for our local DAP client to attach before executing the luafile
  vim.fn.rpcnotify(osv_chan, 'nvim_exec_lua', [[
    local rtp, pp, file = ...
    vim.o.runtimepath = rtp
    vim.o.packpath = pp
    require("osv").launch({ port = 8086, blocking = true, output = true, delay_frozen = 50 })
    vim.cmd('luafile ' .. file)
  ]], { rtp, pp, filename })
  
  -- 4. Attach local DAP client
  vim.defer_fn(function()
    dap.run({
      type = 'nlua',
      request = 'attach',
      name = "OSV Headless",
      host = '127.0.0.1',
      port = 8086,
    })
    vim.notify("OSV: Attached. Background code will start as soon as configuration is done.")
  end, 200)
end

-- Keymaps
vim.keymap.set('n', '<F6>', debug_file, { buffer = true, silent = true, desc = "OSV: Debug this file" })
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>ds', function() 
  require('dap').terminate()
  if osv_chan then pcall(vim.fn.jobstop, osv_chan) osv_chan = nil end
end, { buffer = true, silent = true })

-- Stepping
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { buffer = true, silent = true })
vim.keymap.set('n', '<F8>', function() require('dap').step_over() end, { buffer = true, silent = true })
vim.keymap.set('n', '<F9>', function() require('dap').step_into() end, { buffer = true, silent = true })
vim.keymap.set('n', '<F10>', function() require('dap').step_out() end, { buffer = true, silent = true })
vim.keymap.set('n', '<leader>du', function() require("dapui").toggle() end, { buffer = true, silent = true })

-- Visual mode eval - use old vnoremap style for proper behavior
vim.cmd([[vnoremap <buffer> <silent> <CR> :lua require("dapui").eval()<CR>]])

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(vim.api.nvim_buf_get_name(bufnr),
      { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' })
      or vim.fn.stdpath('config'))
  end,
  single_file_support = true,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
      telemetry = { enable = false },
    },
  },
})
vim.lsp.enable('lua_ls')
