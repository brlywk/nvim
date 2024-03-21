return {
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		-- dependencies = {
		-- 	"rafamadriz/friendly-snippets",
		-- },
		event = "VeryLazy",
		opts = {
			history = true,
			update_events = "TextChanged,TextChangedI",
		},
		config = function()
			local ls = require("luasnip")

			-- load snippets from snippet directory
			--- @diagnostic disable:assign-type-mismatch
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/brlywk/plugins/snippets/" })

			-- some extensions for JavaScript as some snippets should
			-- also be loaded in other filetypes (e.g. jsx should also load js, and tsx should use jsx)
			ls.filetype_extend("typescript", { "javascript" })
			ls.filetype_extend("javascriptreact", { "javascript" })
			ls.filetype_extend("typescriptreact", { "javascriptreact" })

			-- keymaps
			-- expand current item or jump to nex item within snippet
			vim.keymap.set({ "i", "s" }, "<C-j>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true })
			-- jump back
			vim.keymap.set({ "i", "s" }, "<C-k>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true })
			-- cycle through list of choices
			vim.keymap.set("i", "<C-l>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
			vim.keymap.set("i", "<c-u>", require("luasnip.extras.select_choice"))

			-- 'reload' luasnip on changes
			vim.keymap.set(
				"n",
				"<leader><leader>s",
				":so ~/.config/nvim/lua/brlywk/plugins/lualine.lua<CR>",
				{ desc = "Reload LuaSnip snippets" }
			)
		end,
	},
}
