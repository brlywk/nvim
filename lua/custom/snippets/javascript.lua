---@diagnostic disable:undefined-global
return {
    -- functions
    -- arrow functions
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
}
