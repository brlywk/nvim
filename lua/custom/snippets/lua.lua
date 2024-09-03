--- @diagnostic disable:undefined-global
return {
	-- new love project main.lua
	s(
		"l2d",
		fmt(
			[[
---Runs immediately when the game starts.
function love.load()
	-- implement...
end

---Primary game loop. Runs every single frame.
---@param dt? number Delta time
function love.update(dt)
	-- implement...
end

---Draw graphics on the screen. Runs every single frame.
function love.draw()
	-- implement...
end
        ]],
			{}
		)
	),
}
