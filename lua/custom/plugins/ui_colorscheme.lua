return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup {
            style = "night",
            transparent = true,
        }

        vim.cmd "colorscheme tokyonight"
    end,
}

-- return {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     priority = 1000,
--     config = function()
--         require("catppuccin").setup {
--             flavour = "mocha",
--             transparent_background = true,
--         }
--
--         vim.cmd "colorscheme catppuccin"
--     end,
-- }
