local ls = require "luasnip"
local i = ls.insert_node
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
    -- if error
    s(
        "ife",
        fmta(
            [[
			if err != nil {
				return err
			}
			<done>
		]],
            {
                done = i(0),
            }
        )
    ),

    -- error function (function that returns a value and an error)
    s(
        "ef",
        fmta(
            [[
			<val>, <err> := <f>(<args>)
			if <err_same> != nil {
				return <something>, <err_same>
			}
			<done>
		]],
            {
                val = i(1),
                err = i(2, "err"),
                f = i(3),
                args = i(4),
                err_same = rep(2),
                something = i(5),
                done = i(0),
            }
        )
    ),

    -- request handler signature
    s(
        "rh",
        fmta(
            [[
			func <name>(w http.ResponseWriter, r *http.Request) {
				<body>
			}
		]],
            {
                name = i(1),
                body = i(0),
            }
        )
    ),

    -- go main package,
    s(
        "pm",
        fmta(
            [[
			package main

			func main() {
				<done>
			}
		]],
            {
                done = i(0),
            }
        )
    ),

    -- test package
    -- test function
    s(
        "tf",
        fmta(
            [[
			func Test<name>(t *testing.T) {
				<body>
			}
		]],
            {
                name = i(1),
                body = i(0),
            }
        )
    ),

    -- test function for table driven testing
    s(
        "tft",
        fmta(
            [[
            func Test<name>(t *testing.T) {
                tests := []struct{
                    name string
                    <tcdef>
                }{
                    { <tc> },
                }

                for _, tt := range testCases {
                    t.Run(tt.name, func(t *testing.T){
                        <done>
                    })
                }
            }
            ]],
            {
                name = i(1),
                tcdef = i(2),
                tc = i(3),
                done = i(0),
            }
        )
    ),

    -- that require input and output structs
    s(
        "tfs",
        fmta(
            [[
            func Test<name>(t *testing.T) {
                type input struct {
                    <input>
                }

                type output struct {
                    <output>
                }

                testCases := []struct{
                    name     string
                    input    input
                    expected output
                }{
                    { <tc> },
                }

                for _, tc := range testCases {
                    t.Run(tc.name, func(t *testing.T){
                        <done>
                    })
                }
            }
            ]],
            {
                name = i(1),
                input = i(2),
                output = i(3),
                tc = i(4),
                done = i(0),
            }
        )
    ),
}
