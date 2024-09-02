return {
	settings = {
		css = {
			validate = true,
			lint = {
				-- to not show @tailwind rules as warnings
				unknownAtRules = "ignore",
			},
		},
	},
}
