--- @diagnostic disable:undefined-global
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

    -- error if
    s(
        "eif",
        fmta(
            [[
			<val>, <err> := <f>(<args>)
			if <err_same> != nil {
				return <something>
			}
			<done>
		]],
            {
                val = i(1),
                err = i(2, "err"),
                f = i(3),
                args = i(4),
                err_same = rep(2),
                something = rep(2),
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
}
