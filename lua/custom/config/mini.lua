local set = vim.keymap.set

--  Removing Buffers  ------------------------------------
require("mini.bufremove").setup()

set("n", "<leader>bx", function()
    require("mini.bufremove").delete(0, false)
end, { desc = "Delete Buffer" })

set("n", "<leader>bX", function()
    require("mini.bufremove").delete(0, true)
end, { desc = "Force Delete Buffer" })

--  Keymap Clues  ------------------------------------
local miniclue = require("mini.clue")
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
    },

    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),

        -- Leader Subgroups
        { mode = "n", keys = "<Leader><leader>", desc = "+Misc" },
        { mode = "n", keys = "<Leader>b",        desc = "+Buffer" },
        { mode = "n", keys = "<Leader>c",        desc = "+Code" },
        -- { mode = "n", keys = "<Leader>d", desc = "+Debug" },
        { mode = "n", keys = "<Leader>l",        desc = "+Language Server" },
        { mode = "n", keys = "<Leader>f",        desc = "+Find / File" },
        { mode = "n", keys = "<Leader>g",        desc = "+Git" },
        { mode = "n", keys = "<Leader>t",        desc = "+Test" },
        { mode = "n", keys = "<Leader>w",        desc = "+Window (Split)" },
        { mode = "n", keys = "<Leader>x",        desc = "+Trouble" },
        { mode = "n", keys = "<Leader>z",        desc = "+Spellcheck" },
    },
})

--  Highlight Word under cursor  ------------------------------------
require("mini.cursorword").setup()
-- set active word to underline only
vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { fg = "NONE", bg = "NONE", underline = true })
-- set all other occurrences to underline
vim.api.nvim_set_hl(0, "MiniCursorword", { fg = "NONE", bg = "NONE", underline = true })

--  Move text chunks around with Alt = hjkl  ------------------------------------
require("mini.move").setup()

--  Enhanced text operators  ------------------------------------
--  Keymap
--		g=	Evaluate text and replace with result
--		gx	Exchange text regions (gxx for single line)
--		gm	Duplicate line (gmm single line)
--		gs	Sort text (selection)
require("mini.operators").setup()

-- Splits / Joins (expands) argument lists ----------------------------------
-- Keymap: gS
require("mini.splitjoin").setup()

-- Super amazing surround mappings ----------------------------------
-- require("mini.surround").setup()

-- Extended functionality for a/i ---------------------------------
require("mini.ai").setup({ n_lines = 500 })

-- Jump around like a crazy person ---------------------------------
-- require("mini.jump").setup({})
-- require("mini.jump2d").setup({
-- 	view = {
-- 		dim = true,
-- 	},
--
-- 	silent = true,
-- })

-- Indentation lines ---------------------------------
require("mini.indentscope").setup({
    draw = {
        animation = require("mini.indentscope").gen_animation.none(),
    },

    mappings = {
        object_scope = "",
        object_scope_with_border = "",
        goto_top = "[t",
        goto_bottom = "]t",
    },

    symbol = "▏",
})

-- disable indentscope on some filetypes
local mini_indentscope_augroup = vim.api.nvim_create_augroup("MiniIndentscopeDisable", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = mini_indentscope_augroup,
    pattern = { "alpha", "oil" },
    callback = function()
        vim.b.miniindentscope_disable = true
    end,
})
