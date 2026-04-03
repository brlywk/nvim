local ls = require "luasnip"
local i = ls.insert_node
local s = ls.snippet
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local cc = require("config.helper").get_comment_chars

return {
    -- print current date and time
    s(
        "cdt",
        f(function()
            return os.date "%Y/%m/%d - %H:%M"
        end)
    ),
    -- "section comment"
    s(
        "sc",
        fmt(
            [[
            {}
            {} {}
            {}
        ]],
            {
                f(function()
                    local _, char = cc()
                    return string.rep(char, 80)
                end),
                f(function()
                    local start, _ = cc()
                    return start
                end),
                i(0),
                f(function()
                    local _, char = cc()
                    return string.rep(char, 80)
                end),
            }
        )
    ),
    -- "sub section comment"
    s(
        "ssc",
        fmt(
            [[
        {}
        {} {}
        ]],
            {
                f(function()
                    local _, char = cc()
                    return string.rep(char, 50)
                end),
                f(function()
                    local start, _ = cc()
                    return start
                end),
                i(0),
            }
        )
    ),
}
