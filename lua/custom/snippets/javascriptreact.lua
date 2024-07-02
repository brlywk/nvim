--- @diagnostic disable:undefined-global
return {
	-- export react component
	s(
		"rc",
		fmt(
			[[
			export default function {}({}) {{
				{}	

				return <></>
			}}
		]],
			{
				i(1),
				i(2),
				i(0),
			}
		)
	),

	-- client component
	s(
		"rcc",
		fmt(
			[[
			"use client";

			export default function {}({}) {{
				{}	

				return <></>
			}}
		]],
			{
				i(1),
				i(2),
				i(0),
			}
		)
	),

	-- export react async server component
	s(
		"rsc",
		fmt(
			[[
			export default async function {}({}) {{
				{}	

				return <></>
			}}
		]],
			{
				i(1),
				i(2),
				i(0),
			}
		)
	),

	-- component as arrow function
	s(
		"rac",
		fmt(
			[[
			const {} = ({}) => {{
				{}

				return <></>
			}}

			export default {}
		]],
			{
				i(1),
				i(2),
				i(0),
				rep(1),
			}
		)
	),
}
