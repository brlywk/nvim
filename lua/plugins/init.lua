--------------------------------------------------------------------------------
-- Install plugins
--------------------------------------------------------------------------------
local gh = require("config.helper").github_url

vim.pack.add {
    -- theme
    gh "catppuccin/nvim",

    -- the one and only treesitter...
    gh "nvim-treesitter/nvim-treesitter",
    gh "nvim-treesitter/nvim-treesitter-textobjects",
    gh "windwp/nvim-ts-autotag",
    gh "folke/ts-comments.nvim",

    -- dependencies
    gh "nvim-tree/nvim-web-devicons", -- ...what isn't using this?!
    gh "nvim-lua/plenary.nvim", -- ...same here
    gh "SmiteshP/nvim-navic", -- incline.nvim
    gh "b0o/SchemaStore.nvim", -- used in LSP setup to load schema

    -- plugins
    gh "echasnovski/mini.nvim", -- keep high in list, this is also a dependency for some other plugins
    gh "stevearc/oil.nvim",
    gh "williamboman/mason.nvim",
    gh "WhoIsSethDaniel/mason-tool-installer.nvim",
    gh "nvim-lualine/lualine.nvim",
    gh "j-hui/fidget.nvim",
    gh "b0o/incline.nvim",
    gh "folke/lazydev.nvim",
    gh "folke/snacks.nvim",
    gh "folke/which-key.nvim",
    gh "folke/todo-comments.nvim",
    gh "folke/trouble.nvim",
    gh "otavioschwanck/arrow.nvim",
    gh "lewis6991/gitsigns.nvim",
    { src = gh "L3MON4D3/LuaSnip", version = vim.version.range "v2.x" },
    { src = gh "Saghen/blink.cmp", version = vim.version.range "1.x" },
    gh "windwp/nvim-autopairs",
    gh "laytan/cloak.nvim",
    gh "kylechui/nvim-surround",
    gh "stevearc/conform.nvim",
    gh "mfussenegger/nvim-lint",
    gh "danymat/neogen",

    ---- language specific
    -- Gophers!
    gh "ray-x/guihua.lua",
    gh "ray-x/go.nvim",
    -- TypeScript
    gh "marilari88/twoslash-queries.nvim",
}

--------------------------------------------------------------------------------
-- Hooks
--------------------------------------------------------------------------------
-- see: https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html#hooks
vim.api.nvim_create_autocmd("PackChanged", {
    callback = require("plugins.hooks").callback,
})

--------------------------------------------------------------------------------
-- Theme (must run before any other plugins)
--------------------------------------------------------------------------------
require("plugins.theme").setup_theme("catppuccin", {
    flavour = "mocha",
    transparent_background = true,
    float = { solid = true, transparent = true },
    custom_highlights = function(colors)
        return {
            FloatTitle = { bg = colors.none, fg = colors.sapphire },
            FloatBorder = { fg = colors.blue },
        }
    end,
})

--------------------------------------------------------------------------------
-- Custom commands
--------------------------------------------------------------------------------
vim.api.nvim_create_user_command("PackUpdate", ":lua vim.pack.update()", { desc = "Update all installed plugins" })

--------------------------------------------------------------------------------
-- Setup plugins
--------------------------------------------------------------------------------
local setup_dir = vim.fn.stdpath "config" .. "/lua/plugins/setup/*"
local setup_files = vim.fn.glob(setup_dir, false, true)

for _, file in ipairs(setup_files) do
    local f = vim.fn.fnamemodify(file, ":t:r")
    require("plugins.setup." .. f)
end
