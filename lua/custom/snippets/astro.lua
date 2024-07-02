--- @diagnostic disable:undefined-global
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
