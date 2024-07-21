local set = vim.keymap.set

-- little helper for all these keymaps
local setOpts = function(desc, noremap, silent)
	noremap = noremap == nil
	silent = silent == nil

	return { noremap = noremap, silent = silent, desc = desc }
end

----- General preferences -----

-- single character delete? to the infinite void with it!
set("n", "x", '"_x')

----- Cursor improvements -----

-- line-break aware j and k movement
set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- keep cursor in the middle of the screen when moving around
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")

-- keep cursor in the middle when searching
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- for screen sharing: show cursorcolumn and cursorline
set("n", "<leader><leader>=", function()
	local visible = _G.brlywk_crosshair_enabled or false
	vim.opt.cursorcolumn = not visible
	vim.opt.cursorline = not visible
	_G.brlywk_crosshair_enabled = not visible
end, setOpts("Show cursor crosshair"))

set("n", "<leader><leader>-", function()
	local visible = _G.brlywk_line_enabled or false
	vim.opt.cursorline = not visible
	_G.brlywk_line_enabled = not visible
end, setOpts("Show cursor line"))

set("n", "<leader><leader>\\", function()
	local visible = _G.brlywk_column_enabled or false

	vim.opt.cursorcolumn = not visible
	_G.brlywk_column_enabled = not visible
end, setOpts("Show cursor column"))

----- Buffer management -----

-- move between buffers
set("n", "]b", vim.cmd.bnext, setOpts("Next buffer"))
set("n", "[b", vim.cmd.bprev, setOpts("Previous buffer"))
set("n", "<leader>'", "<C-^>", setOpts("Alternate buffer"))

----- Window management -----

-- some shortcuts
set("n", "<leader>wv", "<C-w>v", { desc = "Split vertically" })
set("n", "<leader>wh", "<C-w>s", { desc = "Split horizontally" })
set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close window" })
set("n", "<leader>wo", "<C-w>o", { desc = "Close all other windows" })

-- movement between windows
set("n", "<C-h>", "<C-w>h")
set("n", "<C-j>", "<C-w>j")
set("n", "<C-k>", "<C-w>k")
set("n", "<C-l>", "<C-w>l")

----- Unsetting some keymaps I don't use / need / want -----

-- prevent accidentally entering Ex mode
set("n", "Q", "<Nop>", { noremap = true, silent = true })

-- I don't want to accidentally move around randomly when my fingers get lazy
set({ "i", "n", "v" }, "<left>", "<Nop>", { silent = true })
set({ "i", "n", "v" }, "<right>", "<Nop>", { silent = true })
set({ "i", "n", "v" }, "<up>", "<Nop>", { silent = true })
set({ "i", "n", "v" }, "<down>", "<Nop>", { silent = true })

----- Some other useful stuff -----

-- some useful settings for editing the config and plugin development
set("n", "<leader><leader>r", "<cmd>source %<CR>", { desc = "Reload current file" })
set("n", "<leader><leader>x", "<cmd>.lua<CR>", { desc = "Execute the current (LUA) line" })

-- Try out new inlay hints
set("n", "<leader>ch", function()
	--- @diagnostic disable: missing-parameter
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, setOpts("Toggle inlay hints"))

-- some changes for spellchecking
set("n", "<leader>zs", function()
	local word = vim.fn.expand("<cword>")
	local suggestions = vim.fn.spellsuggest(word)

	if #suggestions == 0 then
		return
	end

	local items = {}
	for i, suggestion in ipairs(suggestions) do
		table.insert(items, string.format("%d. %s", i, suggestion))
	end

	vim.ui.select(items, {
		prompt = "Suggestion for: " .. word,
		format_item = function(item)
			return item
		end,
	}, function(choice)
		if choice then
			local selected = choice:match("%d+. (.+)")
			local row, col = unpack(vim.api.nvim_win_get_cursor(0))
			local line = vim.api.nvim_get_current_line()
			local start_col = vim.fn.matchstrpos(line, "\\k*\\%" .. (col + 1) .. "c\\k*")[2]
			local end_col = vim.fn.matchstrpos(line, "\\k*\\%" .. (col + 1) .. "c\\k*")[3]
			local new_line = line:sub(1, start_col) .. selected .. line:sub(end_col + 1)

			vim.api.nvim_set_current_line(new_line)
			vim.api.nvim_win_set_cursor(0, { row, start_col + #selected - 1 })
		end
	end)
end, setOpts("Suggestions for word"))

set("n", "<leader>zg", "zg", setOpts("Add to dictionary"))
set("n", "<leader>zG", "zug", setOpts("Remove from dictionary"))
set("n", "<leader>zw", "zw", setOpts("Add to bad words"))
set("n", "<leader>zW", "zuw", setOpts("Remove from bad words"))
