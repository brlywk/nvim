----- setup -----
local harpoon = require("harpoon")
harpoon:setup({
	settings = {
		save_on_toggle = true,
		sync_on_ui_close = true,
	},
})

----- keymaps -----
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

opts.desc = "Harpoon: Add file"
set("n", "<leader>a", function()
	harpoon:list():add()
end, opts)
set("n", "<leader>ba", function()
	harpoon:list():add()
end, opts)

opts.desc = "Harpoon: Menu"
set("n", "<leader>bm", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, opts)

opts.desc = "Harpoon: Next"
set("n", "<leader>bn", function()
	harpoon:list():next()
end, opts)

opts.desc = "Harpoon: Previous"
set("n", "<leader>bp", function()
	harpoon:list():prev()
end, opts)

-- set <leader>1...5 to directly jump to file in list
for i = 1, 5 do
	local key = string.format("<leader>%s", i)
	local cmd = string.format("<cmd>lua require('harpoon'):list():select(%s)<CR>", i)
	opts.desc = string.format("Harpoon: Jump to %s", i)

	set("n", key, cmd, opts)
end
