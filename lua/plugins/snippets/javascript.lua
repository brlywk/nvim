local ls = require "luasnip"
local i = ls.insert_node
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt

return {
    -- console.log
    s(
        "cl",
        fmt(
            [[
			console.log({})
		]],
            { i(0) }
        )
    ),
    s(
        "ce",
        fmt(
            [[
			console.error({})
		]],
            { i(0) }
        )
    ),
    s(
        "ct",
        fmt(
            [[
			console.table({})
		]],
            { i(0) }
        )
    ),
}
