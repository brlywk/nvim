local set = vim.keymap.set
local cmd = require("config.helper").cmd
local set_opts = require("config.helper").set_opts

--------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------

-- single delete to the void
set("n", "x", "\"_x")
-- line-break aware j and k
set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", set_opts("", true))
set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", set_opts("", true))
-- keep cursor in the middle when scrolling
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
-- same for searching
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
-- move between buffers
set("n", "]b", vim.cmd.bnext, set_opts "Next buffer")
set("n", "[b", vim.cmd.bprev, set_opts "Previous buffer")
set("n", "<leader>'", "<C-^>", set_opts "Alternate buffer")
-- disable Ex mode
set("n", "Q", "<Nop>", set_opts())
-- disable arrow movement
set({ "i", "n", "v" }, "<left>", "<Nop>", set_opts())
set({ "i", "n", "v" }, "<right>", "<Nop>", set_opts())
set({ "i", "n", "v" }, "<up>", "<Nop>", set_opts())
set({ "i", "n", "v" }, "<down>", "<Nop>", set_opts())
-- window and split controls
set("n", "<C-h>", "<C-w>h")
set("n", "<C-j>", "<C-w>j")
set("n", "<C-k>", "<C-w>k")
set("n", "<C-l>", "<C-w>l")
set("n", "<leader>wv", "<C-w>v", set_opts "Split vertically")
set("n", "<leader>wh", "<C-w>s", set_opts "Split horizontally")
set("n", "<leader>wx", cmd "close", set_opts "Close window")
set("n", "<leader>wo", "<C-w>o", set_opts "Close all other windows")

-- terminal stuff
set("n", "<leader><leader>t", cmd "terminal", set_opts "Terminal")
set("t", "<Esc><Esc>", "<C-\\><C-n>", set_opts "Exit terminal mode")

-- inlay hints
set("n", "<leader>ch", function()
    --- @diagnostic disable: missing-parameter
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, set_opts "Toggle inlay hints")

-- show or hide cursorline
set("n", "<leader><leader>-", function()
    if vim.wo.cursorlineopt == "number" then
        vim.opt.cursorlineopt = "both"
    else
        vim.opt.cursorlineopt = "number"
    end
end, set_opts "Show cursor line")
