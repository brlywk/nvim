----- setup -----
local set = vim.keymap.set

-- neogit
local neogit = require("neogit")
neogit.setup({})

set("n", "<leader>gg", "<cmd>Neogit<CR>", { silent = true, desc = "Open Neogit" })
set("n", "<leader>gc", "<cmd>Neogit commit<CR>", { silent = true, desc = "Open commit window" })

-- diffview
local diffview = require("diffview")
diffview.setup({})

-- only set this keymap for git controlled directories,
-- as diffview throws an error if it's called within a
-- non-git directory
if CHECK_GIT() then
	set("n", "<leader>gd", function()
		local diffview_open = _G.brlywk_diffview_open or false

		if diffview_open then
			_G.brlywk_diffview_open = false
			vim.cmd("DiffviewClose")
		else
			_G.brlywk_diffview_open = true
			vim.cmd("DiffviewOpen")
		end
	end, { desc = "Toggle diffview" })
end

-- gitsigns
local gitsigns = require("gitsigns")
gitsigns.setup({
	-- right between todo and dap
	sign_priority = 15,
	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	on_attach = function(bufnr)
		local opts = { noremap = true, silent = true, buffer = bufnr }

		opts.desc = "Toggle line blame"
		set("n", "<leader>gb", gitsigns.toggle_current_line_blame, opts)
	end,
})
