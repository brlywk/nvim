--------------------------------------------------------------------------------
-- Install plugins
--------------------------------------------------------------------------------
vim.pack.add {
    -- theme
    "https://github.com/catppuccin/nvim",

    -- the one and only...
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",

    -- dependencies
    "https://github.com/nvim-tree/nvim-web-devicons", -- ...what isn't using this?!
    "https://github.com/nvim-lua/plenary.nvim", -- ...same here
    "https://github.com/SmiteshP/nvim-navic", -- incline.nvim
    "https://github.com/b0o/SchemaStore.nvim", -- used in LSP setup to load schema

    -- plugins
    "https://github.com/echasnovski/mini.nvim", -- keep high in list, this is also a dependency for some other plugins
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/j-hui/fidget.nvim",
    "https://github.com/b0o/incline.nvim",
    "https://github.com/folke/lazydev.nvim",
    "https://github.com/folke/snacks.nvim",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/folke/todo-comments.nvim",
    "https://github.com/folke/trouble.nvim",
    "https://github.com/otavioschwanck/arrow.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range "v2.x" },
    { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range "1.x" },
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/laytan/cloak.nvim",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/mfussenegger/nvim-lint",
    "https://github.com/danymat/neogen",

    ---- language specific
    -- Gophers!
    "https://github.com/ray-x/guihua.lua",
    "https://github.com/ray-x/go.nvim",
    -- TypeScript
    "https://github.com/marilari88/twoslash-queries.nvim",
}

--------------------------------------------------------------------------------
-- Hooks (must run to build plugins etc.)
--------------------------------------------------------------------------------
-- taken from this fantastic blog: https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html#hooks
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then
                vim.cmd.packadd "nvim-treesitter"
            end
            vim.cmd "TSUpdate"
        end
    end,
})

--------------------------------------------------------------------------------
-- Theme (must run first)
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
-- Setup plugins
--------------------------------------------------------------------------------
local setup_dir = vim.fn.stdpath "config" .. "/lua/plugins/setup/*"
local setup_files = vim.fn.glob(setup_dir, false, true)

for _, file in ipairs(setup_files) do
    local f = vim.fn.fnamemodify(file, ":t:r")
    require("plugins.setup." .. f)
end
