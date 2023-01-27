-- Setup nvim-cmp.
local cmp = require("cmp")
local source_mapping = {
	buffer = "[Buffer]", keyword_length = 5,
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	path = "[Path]",
}

cmp.setup({
	snippet = {
		expand = function(args)

			require("luasnip").lsp_expand(args.body)

		end,
	},
	mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
	}),

	formatting = {
		format = function(entry, vim_item)
			-- vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			vim_item.menu = menu
			return vim_item
		end,
	},

	sources = {

		{ name = "nvim_lsp" },

		-- For luasnip user.
		{ name = "luasnip" },

		{ name = "buffer" },

		{ name = "path" },

		-- { name = "cmdline",
        --   option = {
        --   ignore_cmds = { 'Man', '!', "*" }
        --   }
		-- },
	},
})
