local ls = require "luasnip"
local i = ls.insert_node
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta

return {
    -- astro component
    s(
        "ac",
        fmta(
            [[
			---
			<frontmatter>
			---

			<body>
		]],
            {
                frontmatter = i(1),
                body = i(0),
            }
        )
    ),
}
