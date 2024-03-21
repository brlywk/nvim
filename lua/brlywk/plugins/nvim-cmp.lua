return {
	"hrsh7th/nvim-cmp",
	cond = not vim.g.vscode,
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- source for nvim lsp
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help", -- show function signature while parameter list
		"hrsh7th/cmp-nvim-lsp-document-symbol", -- use /@ to quick find document symbols
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
	},
	opts = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- load cmdline support
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "nvim_lsp_document_symbol" },
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})

		-- some colors
		local colors = require("brlywk.config.colors")
		vim.cmd("hi CmpDocBorder guifg=" .. colors.CmpDocBorderFg .. " guibg=" .. colors.CmpDocBorderBg)
		vim.cmd("hi CmpSel guifg=" .. colors.CmpSelFg .. " guibg=" .. colors.CmpSelBg)

		return {
			-- never ever ever ever ever preselect a completion suggestion... ever!
			preselect = cmp.PreselectMode.None,
			completion = {
				completeopt = "menuone,noselect,noinsert,preview",
			},
			window = {
				completion = {
					border = "single",
					winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
				},
				documentation = {
					border = "single",
					winhighlight = "Normal:CmpDoc",
				},
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				-- previous suggestion
				-- ["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				-- next suggestion
				-- ["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				-- show completion suggestions
				["<C-Space>"] = cmp.mapping.complete(),
				-- close completion window
				["<C-e>"] = cmp.mapping.abort(),
				-- ["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				-- ["<Tab>"] = cmp.mapping(function(fallback)
				-- 	if cmp.visible() then
				-- 		cmp.select_next_item()
				-- 	else
				-- 		fallback()
				-- 	end
				-- end, { "i", "s" }),
				-- ["<S-Tab>"] = cmp.mapping(function(fallback)
				-- 	if cmp.visible() then
				-- 		cmp.select_prev_item()
				-- 	else
				-- 		fallback()
				-- 	end
				-- end, { "i", "s" }),

				-- ["<C-n>"] = cmp.config.disable,
				-- ["<C-p>"] = cmp.config.disable,
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				-- default sources
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "path" },

				-- signature help
				{ name = "nvim_lsp_signature_help" },

				-- Snippets
				{ name = "luasnip" },

				-- Copilot Source
				{ name = "copilot" },
			}),
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = function(_, item)
					local icons = require("brlywk.config.icons").kinds
					if icons[item.kind] then
						item.kind = icons[item.kind] .. item.kind
					end
					return item
				end,
			},
		}
	end,
}
