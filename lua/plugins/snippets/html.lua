local ls = require "luasnip"
local i = ls.insert_node
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt

return {
    s(
        "h!",
        fmt(
            [[
		<!DOCTYPE html>
		<html lang="en">
			<head>
				<title>{}</title>
				<meta charset="UTF-8">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<link href="{}" rel="stylesheet">
			</head>
			<body>
				{}
			</body>
		</html>
		]],
            {
                i(1),
                i(2),
                i(0),
            }
        )
    ),
}
