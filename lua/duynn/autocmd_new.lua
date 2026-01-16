-- Simplified autocmds - filetype-specific moved to ftplugin/
local vim = vim
local api = vim.api

-- Restore cursor position
api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local line = vim.fn.line("'\"")
		if line > 1 and line <= vim.fn.line("$") then
			vim.cmd("normal! g'\"")
		end
	end,
})

-- Prevent loss of clipboard when leaving buffer
api.nvim_create_autocmd("BufLeave", {
	pattern = "*",
	callback = function()
		vim.fn.system("xsel -ib", vim.fn.getreg('+'))
	end,
})

-- Quickfix buffer mapping
api.nvim_create_autocmd("BufReadPost", {
	pattern = "quickfix",
	callback = function()
		vim.keymap.set('n', '<CR>', '<CR>', { buffer = true })
	end,
})

-- Large file handling
local large_file = 2 * 1024 * 1024 -- 2MB
api.nvim_create_autocmd("BufReadPre", {
	pattern = "*",
	callback = function()
		local file = vim.fn.expand("<afile>")
		local size = vim.fn.getfsize(file)
		
		-- Special handling for .pb.go files (protobuf generated)
		-- These are large but we still want LSP
		local is_protobuf = file:match("%.pb%.go$") ~= nil
		
		if (size > large_file or size == -2) and not is_protobuf then
			-- Schedule to run after other BufReadPre events (like LSP loading)
			vim.schedule(function()
				vim.opt_local.eventignore:append("FileType")
				vim.opt_local.number = false
				vim.opt_local.relativenumber = false
				vim.opt_local.swapfile = false
				vim.opt_local.bufhidden = "unload"
				vim.opt_local.buftype = "nowrite"
				vim.opt_local.undolevels = -1
			end)
		elseif is_protobuf then
			-- For protobuf files: keep LSP but disable heavy features
			vim.opt_local.swapfile = false
			vim.opt_local.undolevels = 100  -- Limited undo
			-- Don't block FileType event so LSP can attach
		end
	end,
})

-- Floaterm resize handling
api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	command = "FloatermUpdate",
})

-- Misc file types
api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.conf",
	command = "setf dosini",
})
