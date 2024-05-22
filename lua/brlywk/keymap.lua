local set = vim.keymap.set

----- General preferences -----

-- single character delete? to the infinite void with it!
set("n", "x", '"_x')

----- Cursor improvements -----

-- line-break aware j and k movement
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- keep cursor in the middle of the screen when moving around
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")

-- keep cursor in the middle when searching
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- for screensharing: show cursorcolumn and cursorline
set("n", "<leader><leader>=", function()
    local visible = _G.brlywk_crosshair_enabled or false
    vim.opt.cursorcolumn = not visible
    vim.opt.cursorline = not visible
    _G.brlywk_crosshair_enabled = not visible
end, { noremap = true, silent = true, desc = "Show cursor crosshair" })

set("n", "<leader><leader>-", function()
    local visible = _G.brlywk_line_enabled or false
    vim.opt.cursorline = not visible
    _G.brlywk_line_enabled = not visible
end, { noremap = true, silent = true, desc = "Show cursor line" })

set("n", "<leader><leader>\\", function()
    local visible = _G.brlywk_column_enabled or false

    vim.opt.cursorcolumn = not visible
    _G.brlywk_column_enabled = not visible
end, { noremap = true, silent = true, desc = "Show cursor column" })

----- Buffer management -----

-- move between buffers
set("n", "]b", vim.cmd.bnext, { noremap = true, silent = true, desc = "Next buffer" })
set("n", "[b", vim.cmd.bprev, { noremap = true, silent = true, desc = "Previous buffer" })
set("n", "<leader>'", "<C-^>", { desc = "Alternate buffer" })

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
end, { noremap = true, desc = "Toggle inlay hints" })
