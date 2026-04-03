local M = {}

-- border_style is the default border style to use for any kind of "stylable
-- window"
M.border_style = "rounded"

M.highlight_overrides = function()
    vim.api.nvim_set_hl(0, "WinSeparator", { link = "FloatBorder" })

    local colors = require("catppuccin.palettes").get_palette "mocha"
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = colors.blue, bg = colors.base })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { fg = colors.base, bg = colors.blue })
    vim.api.nvim_set_hl(0, "BlinkCmpScrollBarThumb", { bg = colors.blue })
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", { fg = colors.base, bg = colors.blue })
end

-- configure current theme
-- this is done outside plugin setup to not interfere with the current
-- automatic loading of all files in the "setup" folder
M.setup_theme = function(name, opts)
    vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("theme_change", { clear = true }),
        callback = M.highlight_overrides
    })

    require(name).setup(opts)
    vim.cmd.colorscheme(name)
end

return M
