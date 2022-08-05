local vim = vim
local api = vim.api

-- Taken from https://github.com/norcalli/nvim_utils
local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_create_augroup(group_name, {})
        for _, def in ipairs(definition) do
            api.nvim_create_autocmd(def[1], {pattern=def[2], command=def[3]})
        end
    end
end

local autocmds = {
    -- For help files, make <Return> behave like <C-]> (jump to tag)
    help = {
        { "FileType", "*.py", "let a=1" }
	}
}

nvim_create_augroups(autocmds)
