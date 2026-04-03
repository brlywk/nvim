--------------------------------------------------------------------------------
-- Setup
--------------------------------------------------------------------------------
require("trouble").setup {
    win = {
        border = require "plugins.theme".border_style
    }
}

--------------------------------------------------------------------------------
-- Keymap
--------------------------------------------------------------------------------
local set = vim.keymap.set
local cmd = require "config.helper".cmd
local set_opts = require "config.helper".set_opts

set("n", "<leader>xx", cmd "Trouble diagnostics toggle", set_opts "Diagnostics (Trouble)")
set("n", "<leader>xX", cmd "Trouble diagnostics toggle filter.buf=0", set_opts "Buffer Diagnostics (Trouble)")
set("n", "<leader>ct", cmd "Trouble symbols toggle focus=true", set_opts "Symbol Tree")
set("n", "<leader>cl", cmd "Trouble lsp toggle focus=false win.position=right",
    set_opts "LSP Definitions / references / ...")
set("n", "<leader>xL", cmd "Trouble loclist toggle", set_opts "Location List (Trouble)")
set("n", "<leader>xQ", cmd "Trouble qflist toggle", set_opts "Quickfix List (Trouble)")
