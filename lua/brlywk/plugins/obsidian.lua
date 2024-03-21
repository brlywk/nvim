--- @diagnostic disable:missing-fields
return {
	"epwalsh/obsidian.nvim",
	cond = not vim.g.vscode,
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	event = {
		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		"BufReadPre /Users/christoph/Obsidian/Default/**.md",
	},
	keys = {
		{ "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open Obsidian App" },
		{ "<leader>oc", "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>", desc = "Toggle Obsidian Checkbox" },
		{ "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Show Obsidian Backlinks" },
		{ "<leader>ol", "<cmd>ObsidianLinks<CR>", desc = "Show Obsidian Links" },
		{ "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New Note" },
		{ "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search Obsidian" },
		{ "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick Switch" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- ft = "markdown",
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "/Users/christoph/Obsidian/Default",
			},
		},
		notes_subdir = "00 Inbox",
		completion = {
			nvim_cmp = true,
			min_chars = 2,
			new_notes_location = "current_dir",
		},
		ui = {
			-- set this to false if conceallevel settings impact other workflows to much
			enabled = true,
		},
		-- overwrite new note naming function to use title as note file name
		note_id_func = function(title)
			local isoDate = os.date("%Y-%m-%d", os.time())
			local fileName = title

			if title == nil then
				for _ = 1, 4 do
					fileName = "New Note " .. string.char(math.random(65, 90))
				end
			end

			return isoDate .. " - " .. fileName
		end,
	},
}
