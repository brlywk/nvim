return {
    "echasnovski/mini.nvim",
    version = false,
    enabled = true,
    config = function()
        local set = vim.keymap.set

        ---- Buffers ----
        require("mini.bufremove").setup()

        set("n", "<leader>bx", function()
            require("mini.bufremove").delete(0, false)
        end, { desc = "Delete Buffer" })

        set("n", "<leader>bX", function()
            require("mini.bufremove").delete(0, true)
        end, { desc = "Force Delete Buffer" })

        ---- Highlight cursorword ----
        require("mini.cursorword").setup()
        vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { fg = "NONE", bg = "NONE", underline = true })
        vim.api.nvim_set_hl(0, "MiniCursorword", { fg = "NONE", bg = "NONE", underline = true })

        ---- Move lines with Alt ----
        require("mini.move").setup()

        ---- Jump: Repeated f/t motions ----
        require("mini.jump").setup()

        ---- Icons ----
        require("mini.icons").setup()
        --- Sessions ----
        require("mini.sessions").setup()

        ---- Enhanced operators ----
        require("mini.operators").setup {
            replace = {
                prefix = "",
            },
        }

        ---- Split / join argument lists ----
        require("mini.splitjoin").setup()

        ---- Extended a/i functionality ----
        require("mini.ai").setup { n_lines = 500 }

        ---- Override some color settings ----
        local theme_flavour = require("config.plugins").theme_flavour
        local theme_colors = require("catppuccin.palettes").get_palette(theme_flavour)
        vim.api.nvim_set_hl(0, "MiniJump", {
            fg = theme_colors.base,
            bg = theme_colors.sky,
        })
    end,
}
