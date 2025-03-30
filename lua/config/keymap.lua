---- Helper ----
local set = vim.keymap.set
local unset = vim.keymap.del
local setOpts = function(desc, expr, noremap, silent)
    noremap = noremap == nil
    silent = silent == nil
    expr = expr == true
    desc = desc or ""

    return { noremap = noremap, expr = expr, silent = silent, desc = desc }
end

---- Keymaps ----
-- single delete to the void
set("n", "x", '"_x')
-- line-break aware j and k
set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", setOpts("", true))
set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", setOpts("", true))
-- keep cursor in the middle when scrolling
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
-- same for searching
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
-- move between buffers
set("n", "]b", vim.cmd.bnext, setOpts "Next buffer")
set("n", "[b", vim.cmd.bprev, setOpts "Previous buffer")
set("n", "<leader>'", "<C-^>", setOpts "Alternate buffer")
-- disable Ex mode
set("n", "Q", "<Nop>", setOpts())
-- disable arrow movement
set({ "i", "n", "v" }, "<left>", "<Nop>", setOpts())
set({ "i", "n", "v" }, "<right>", "<Nop>", setOpts())
set({ "i", "n", "v" }, "<up>", "<Nop>", setOpts())
set({ "i", "n", "v" }, "<down>", "<Nop>", setOpts())
-- window and split controls
set("n", "<C-h>", "<C-w>h")
set("n", "<C-j>", "<C-w>j")
set("n", "<C-k>", "<C-w>k")
set("n", "<C-l>", "<C-w>l")
set("n", "<leader>wv", "<C-w>v", setOpts "Split vertically")
set("n", "<leader>wh", "<C-w>s", setOpts "Split horizontally")
set("n", "<leader>wx", "<cmd>close<CR>", setOpts "Close window")
set("n", "<leader>wo", "<C-w>o", setOpts "Close all other windows")

---- Useful for config changes and plugin development ----
set("n", "<leader><leader>r", "<cmd>source %<CR>", setOpts "Reload current file")
set("n", "<leader><leader>x", "<cmd>.lua<CR>", setOpts "Execute the current (LUA) line")

---- Testing these out for a time ----
-- inlay hints
set("n", "<leader>ch", function()
    --- @diagnostic disable: missing-parameter
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, setOpts "Toggle inlay hints")

---- Just some settings for screensharing ----
set("n", "<leader><leader>=", function()
    local visible = _G.brlywk_crosshair_enabled or false
    vim.opt.cursorcolumn = not visible
    vim.opt.cursorline = not visible
    _G.brlywk_crosshair_enabled = not visible
end, setOpts "Show cursor crosshair")

set("n", "<leader><leader>-", function()
    local visible = _G.brlywk_line_enabled or false
    vim.opt.cursorline = not visible
    _G.brlywk_line_enabled = not visible
end, setOpts "Show cursor line")

set("n", "<leader><leader>\\", function()
    local visible = _G.brlywk_column_enabled or false

    vim.opt.cursorcolumn = not visible
    _G.brlywk_column_enabled = not visible
end, setOpts "Show cursor column")
