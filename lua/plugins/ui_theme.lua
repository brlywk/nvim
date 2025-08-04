return {
    "catppuccin/nvim",
    enabled = true,
    name = "catppuccin",
    priority = 1000,
    config = function()
        local theme_flavour = require("config.plugins").theme_flavour

        require("catppuccin").setup {
            flavour = theme_flavour,
            transparent_background = true,
            float = { solid = true, transparent = true },
            custom_highlights = function(colors)
                return {
                    FloatTitle = { bg = colors.none, fg = colors.sapphire },
                    FloatBorder = { fg = colors.blue },
                }
            end,
        }

        vim.cmd "colorscheme catppuccin"
    end,
}
