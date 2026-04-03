local set = vim.keymap.set

--------------------------------------------------------------------------------
-- Buffers
--------------------------------------------------------------------------------
require("mini.bufremove").setup()

set("n", "<leader>bx", function()
    require("mini.bufremove").delete(0, false)
end, { desc = "Delete Buffer" })

set("n", "<leader>bX", function()
    require("mini.bufremove").delete(0, true)
end, { desc = "Force Delete Buffer" })

--------------------------------------------------------------------------------
-- Cursorword
--------------------------------------------------------------------------------
require("mini.cursorword").setup()
vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { fg = "NONE", bg = "NONE", underline = true })
vim.api.nvim_set_hl(0, "MiniCursorword", { fg = "NONE", bg = "NONE", underline = true })

--------------------------------------------------------------------------------
-- Others (no additional setup)
--------------------------------------------------------------------------------
require("mini.move").setup()
require("mini.jump").setup()
require("mini.icons").setup()
require("mini.sessions").setup()
require("mini.splitjoin").setup()
require("mini.ai").setup { n_lines = 500 }
require("mini.operators").setup {
    replace = {
        prefix = "",
    },
}

--------------------------------------------------------------------------------
-- Customization
--------------------------------------------------------------------------------
local theme_colors = require("catppuccin.palettes").get_palette "mocha"
vim.api.nvim_set_hl(0, "MiniJump", {
    fg = theme_colors.base,
    bg = theme_colors.sky,
})
