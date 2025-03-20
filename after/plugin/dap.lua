vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})


local dap = require"dap"
dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
    host = function()
      local value = vim.fn.input('Host [127.0.0.1]: ')
      if value ~= "" then
        return value
      end
      return '127.0.0.1'
    end,
    port = function()
      local val = tonumber(vim.fn.input('Port: '))
      assert(val, "Please provide a port number")
      return val
    end,
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host, port = config.port })
end


-- go debugger configurations
dap.configurations.go = {
  {
	type = 'go',
	name = "Debug",
	request = "launch",
    outputMode = "remote",
	program = function()
	  local git_files = vim.fn.systemlist('git ls-files | grep main.go$')
	  local enum_git_files = vim.fn.systemlist('git ls-files | grep main.go$ | grep -n main.go$')
	  local selected_file = vim.fn.inputlist(enum_git_files)
	  -- strip number and space
	  selected_file = string.gsub(selected_file, '%d+ ', '')
	  -- selected_file to int
	  selected_file = tonumber(selected_file)
	  return git_files[selected_file]
	end

  },
  -- debug (args) main.go
  {
	type = 'go',
	name = "Debug (args)",
	request = "launch",
    outputMode = "remote",
	program = function()
	  local git_files = vim.fn.systemlist('git ls-files | grep main.go$')
	  local enum_git_files = vim.fn.systemlist('git ls-files | grep main.go$ | grep -n main.go$')
	  local selected_file = vim.fn.inputlist(enum_git_files)
	  -- strip number and space
	  selected_file = string.gsub(selected_file, '%d+ ', '')
	  -- selected_file to int
	  selected_file = tonumber(selected_file)
	  return git_files[selected_file]
	end,
	-- input args
	args = function()
	  local args = vim.fn.input('Args: ')
	  return vim.split(args, ' ')
	end
  },
  -- debug current file
  {
	type = 'go',
	name = "Debug current file",
	request = "launch",
    outputMode = "remote",
	program = "${file}"
  },
  -- debug (args) current file
  {
	type = 'go',
	name = "Debug current file with args",
	request = "launch",
    outputMode = "remote",
	program = "${file}",
	-- input args
	args = function()
	  local args = vim.fn.input('Args: ')
	  return vim.split(args, ' ')
	end
  },
  -- debug test
  {
	type = 'go',
	name = "Debug test",
	request = "launch",
    outputMode = "remote",
	mode = "test",
	program = "${file}"
  },
}

dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = 'Launch file';

        program = "${file}";  -- This configuration will launch the current file if used.
        pythonPath = function()
            return "/home/duy/python/src/debugpy/bin/python"  -- Update with your Python path
        end;
        justMyCode = false;  -- Set this to false to include library and framework code
    },
}


-- php debugger configurations step

-- install phpDebug : git clone https://github.com/xdebug/vscode-php-debug.git; cd vscode-php-debug; npm install && npm run build
-- install php-xdebug
-- config xdebug: append below lines to /etc/php/php.ini
--[[
[xdebug]
zend_extension=xdebug
xdebug.mode=debug
xdebug.start_with_request=yes
xdebug.client_host=127.0.0.1
xdebug.client_port=9003
xdebug.log=/tmp/xdebug.log
]]

dap.adapters.php = {
    type = "executable",
    command = "node",
    args = { "/home/duy/.trash/vscode-php-debug/out/phpDebug.js" }
}

dap.configurations.php = {
    {
        name = "run current script",
        type = "php",
        request = "launch",
		cwd = "${fileDirname}",
		program = "${file}",
		runtimeExecutable = "php",
		-- log = true,
	},
    {
        name = "listen address",
        type = "php",
        request = "launch",
        port = 9003,
	}
}
