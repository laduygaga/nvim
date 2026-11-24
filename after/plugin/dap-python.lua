local dap_python = require('dap-python')

local debugpy_python = vim.fn.expand('~/.virtualenvs/debugpy/bin/python')
if vim.fn.executable(debugpy_python) == 0 then
  debugpy_python = '/usr/bin/python3'
end

dap_python.setup(debugpy_python, {
  include_configs = true,
})

local dap = require('dap')
dap.configurations.python = dap.configurations.python or {}

table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = 'Launch file (.venv)',
  program = '${file}',
  pythonPath = function()
    local cwd = vim.fn.getcwd()
    if vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
      return cwd .. '/.venv/bin/python'
    elseif vim.fn.executable(cwd .. '/env/bin/python') == 1 then
      return cwd .. '/env/bin/python'
    else
      return '/usr/bin/python3'
    end
  end,
  justMyCode = false,
})

