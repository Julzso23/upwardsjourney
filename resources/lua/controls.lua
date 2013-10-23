jpm.controls = {}

function jpm.controls.keyboard(dt)
	local left = love.keyboard.isDown("left") or love.keyboard.isDown("a")
	local right = love.keyboard.isDown("right") or love.keyboard.isDown("d")

	if left then
		jpm.players[1]:move("left", dt, 1)
	end
	if right then
		jpm.players[1]:move("right", dt, 1)
	end
	if left and right then
		jpm.players[1]:idle()
	end
	if not left and not right then
		jpm.players[1]:idle()
	end
end

function jpm.controls.controller(dt)
	local left = love.keyboard.isDown("left") or love.keyboard.isDown("a")
	local right = love.keyboard.isDown("right") or love.keyboard.isDown("d")
	local axis = love.joystick.getAxis(1, 1)

	if axis > 0.03 then
		jpm.players[1]:move("right", dt, axis)
	end
	if axis < -0.03 then
		jpm.players[1]:move("left", dt, -axis)
	end
	if axis > -0.03 and axis < 0.03 and not left and not right then
		jpm.players[1]:idle()
	end
end