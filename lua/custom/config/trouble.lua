--- setup -----
local trouble = require("trouble")
trouble.setup({
	modes = {
		split_diagnostics = {
			mode = "diagnostics",
			preview = {
				type = "split",
				relative = "win",
				position = "right",
				size = 0.3,
			},
		},
		doc_and_project = {
			mode = "diagnostics", -- inherit from diagnostics mode
			filter = {
				any = {
					buf = 0, -- current buffer
					{
						severity = vim.diagnostic.severity.ERROR, -- errors only
						-- limit to files in the current project
						function(item)
							return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
						end,
					},
				},
			},
		},
		cascade = {
			mode = "diagnostics", -- inherit from diagnostics mode
			filter = function(items)
				local severity = vim.diagnostic.severity.HINT
				for _, item in ipairs(items) do
					severity = math.min(severity, item.severity)
				end
				return vim.tbl_filter(function(item)
					return item.severity == severity
				end, items)
			end,
		},
	},
})

-- keymap -----
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

opts.desc = "Document diagnostics"
set("n", "<leader>xd", function()
	trouble.open({ mode = "split_diagnostics", focus = true })
end, opts)

opts.desc = "Workspace diagnostics"
set("n", "<leader>xw", function()
	trouble.open({ mode = "doc_and_project", focus = true })
end, opts)

opts.desc = "Toggle"
set("n", "<leader>xx", function()
	trouble.toggle({ mode = "cascade", focus = true })
end, opts)
