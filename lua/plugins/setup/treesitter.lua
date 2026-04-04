---@diagnostic disable: missing-fields

--------------------------------------------------------------------------------
-- Setup Treesitter
--------------------------------------------------------------------------------
local ts = require "nvim-treesitter"
ts.setup()

-- treesitter should ignore these "languages"
local ignore_exact = {
    "oil",
    "incline",
    "fidget",
    "mason",
    "trouble",
}
local ignore_prefix = {
    "snacks_",
    "blink-",
    "conform-",
}

-- as a lazy developer, let's just handle treesitter all the work;
-- I can wait a second or two when opening a project with a "new language" :P
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter_filetype", { clear = true }),
    callback = function(args)
        -- skip start and installation for any ignored filetypes
        if vim.tbl_contains(ignore_exact, args.match) then
            return
        end

        -- some plugins create a slew of virtual filetypes... ignore them!
        for _, prefix in ipairs(ignore_prefix) do
            if vim.startswith(args.match, prefix) then
                return
            end
        end

        -- check if there is a known language for this filetype
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
            return
        end

        -- if we cannot start treesitter, the language is probably not
        -- installed...
        local ok = pcall(vim.treesitter.start, args.buf, lang)
        if not ok then
            ts.install(lang)
        end
    end,
})

--------------------------------------------------------------------------------
-- Setup autopairs and comments
--------------------------------------------------------------------------------
require("nvim-autopairs").setup {
    check_ts = true,
    ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
    },
}

require("ts-comments").setup {}

--------------------------------------------------------------------------------
-- Setup treesitter-textobjects
--------------------------------------------------------------------------------
require("nvim-treesitter-textobjects").setup {
    select = {
        lookahead = true,
        selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            -- ['@class.outer'] = '<c-v>', -- blockwise
        },
    },
    move = {
        set_jumps = true,
    },
}

local set = vim.keymap.set
local set_opts = require("config.helper").set_opts

---- select
local select = require "nvim-treesitter-textobjects.select"

-- assignments
set({ "x", "o" }, "a=", function()
    select.select_textobject("@assignment.outer", "textobjects")
end, set_opts "Select outer part of an assignment")
set({ "x", "o" }, "i=", function()
    select.select_textobject("@assignment.inner", "textobjects")
end, set_opts "Select inner part of an assignment")
set({ "x", "o" }, "l=", function()
    select.select_textobject("@assignment.lhs", "textobjects")
end, set_opts "Select left hand side of an assignment")
set({ "x", "o" }, "r=", function()
    select.select_textobject("@assignment.rhs", "textobjects")
end, set_opts "Select right hand side of an assignment")
-- parameters / arguments
set({ "x", "o" }, "aa", function()
    select.select_textobject("@parameter.outer", "textobjects")
end, set_opts "Select outer part of a parameter/argument")
set({ "x", "o" }, "ia", function()
    select.select_textobject("@parameter.inner", "textobjects")
end, set_opts "Select inner part of a parameter/argument")
-- conditionals
set({ "x", "o" }, "ai", function()
    select.select_textobject("@conditional.outer", "textobjects")
end, set_opts "Select outer part of a conditional")
set({ "x", "o" }, "ii", function()
    select.select_textobject("@conditional.inner", "textobjects")
end, set_opts "Select inner part of a conditional")
-- loops
set({ "x", "o" }, "al", function()
    select.select_textobject("@loop.outer", "textobjects")
end, set_opts "Select outer part of a loop")
set({ "x", "o" }, "il", function()
    select.select_textobject("@loop.inner", "textobjects")
end, set_opts "Select inner part of a loop")
-- calls
set({ "x", "o" }, "ac", function()
    select.select_textobject("@call.outer", "textobjects")
end, set_opts "Select outer part of a (function) call")
set({ "x", "o" }, "ic", function()
    select.select_textobject("@call.inner", "textobjects")
end, set_opts "Select inner part of a (function) call")
-- functions
set({ "x", "o" }, "af", function()
    select.select_textobject("@function.outer", "textobjects")
end, set_opts "Select outer part of a function definition")
set({ "x", "o" }, "if", function()
    select.select_textobject("@function.inner", "textobjects")
end, set_opts "Select inner part of a function definition")
-- structs / classes
set({ "x", "o" }, "as", function()
    select.select_textobject("@class.outer", "textobjects")
end, set_opts "Select outer part of a struct (class)")
set({ "x", "o" }, "is", function()
    select.select_textobject("@class.inner", "textobjects")
end, set_opts "Select inner part of a struct (class)")

---- move
local move = require "nvim-treesitter-textobjects.move"

-- goto_next_start
set({ "n", "x", "o" }, "]c", function()
    move.goto_next_start("@call.outer", "textobjects")
end, set_opts "Next function call start")
set({ "n", "x", "o" }, "]f", function()
    move.goto_next_start("@function.outer", "textobjects")
end, set_opts "Next method/function def start")
set({ "n", "x", "o" }, "]s", function()
    move.goto_next_start("@class.outer", "textobjects")
end, set_opts "Next class start")
set({ "n", "x", "o" }, "]i", function()
    move.goto_next_start("@conditional.outer", "textobjects")
end, set_opts "Next conditional start")
set({ "n", "x", "o" }, "]l", function()
    move.goto_next_start("@loop.outer", "textobjects")
end, set_opts "Next loop start")
set({ "n", "x", "o" }, "]z", function()
    move.goto_next_start("@fold", "folds")
end, set_opts "Next fold")
set({ "n", "x", "o" }, "]a", function()
    move.goto_next_start("@argument.inner", "textobjects")
end, set_opts "Next inner argument")
-- goto_next_end
set({ "n", "x", "o" }, "]C", function()
    move.goto_next_end("@call.outer", "textobjects")
end, set_opts "Next function call end")
set({ "n", "x", "o" }, "]F", function()
    move.goto_next_end("@function.outer", "textobjects")
end, set_opts "Next method/function def end")
set({ "n", "x", "o" }, "]S", function()
    move.goto_next_end("@class.outer", "textobjects")
end, set_opts "Next class end")
set({ "n", "x", "o" }, "]I", function()
    move.goto_next_end("@conditional.outer", "textobjects")
end, set_opts "Next conditional end")
set({ "n", "x", "o" }, "]L", function()
    move.goto_next_end("@loop.outer", "textobjects")
end, set_opts "Next loop end")
set({ "n", "x", "o" }, "]A", function()
    move.goto_next_end("@argument.outer", "textobjects")
end, set_opts "Next outer argument end")
-- goto_previous_start
set({ "n", "x", "o" }, "[c", function()
    move.goto_previous_start("@call.outer", "textobjects")
end, set_opts "Prev function call start")
set({ "n", "x", "o" }, "[f", function()
    move.goto_previous_start("@function.outer", "textobjects")
end, set_opts "Prev method/function def start")
set({ "n", "x", "o" }, "[s", function()
    move.goto_previous_start("@class.outer", "textobjects")
end, set_opts "Prev class start")
set({ "n", "x", "o" }, "[i", function()
    move.goto_previous_start("@conditional.outer", "textobjects")
end, set_opts "Prev conditional start")
set({ "n", "x", "o" }, "[l", function()
    move.goto_previous_start("@loop.outer", "textobjects")
end, set_opts "Prev loop start")
set({ "n", "x", "o" }, "[a", function()
    move.goto_previous_start("@argument.inner", "textobjects")
end, set_opts "Prev inner argument")
-- goto_previous_end
set({ "n", "x", "o" }, "[C", function()
    move.goto_previous_end("@call.outer", "textobjects")
end, set_opts "Prev function call end")
set({ "n", "x", "o" }, "[F", function()
    move.goto_previous_end("@function.outer", "textobjects")
end, set_opts "Prev method/function def end")
set({ "n", "x", "o" }, "[S", function()
    move.goto_previous_end("@class.outer", "textobjects")
end, set_opts "Prev class end")
set({ "n", "x", "o" }, "[I", function()
    move.goto_previous_end("@conditional.outer", "textobjects")
end, set_opts "Prev conditional end")
set({ "n", "x", "o" }, "[L", function()
    move.goto_previous_end("@loop.outer", "textobjects")
end, set_opts "Prev loop end")
set({ "n", "x", "o" }, "[A", function()
    move.goto_previous_end("@argument.inner", "textobjects")
end, set_opts "Prev inner argument end")

---- swap
local swap = require "nvim-treesitter-textobjects.swap"

set("n", "<M-l>", function()
    swap.swap_next "@parameter.inner"
end, set_opts "Swap with next parameter")
set("n", "<M-h>", function()
    swap.swap_previous "@parameter.inner"
end, set_opts "Swap with previous parameter")
