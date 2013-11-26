jpm.controls = {}

function jpm.controls.keyboard(dt)
	--Make the game close with alt+f4
	if love.keyboard.isDown("lalt") and love.keyboard.isDown("f4") then
		love.event.push("quit")
	end

	--Define what the left and right keys are
	local left = love.keyboard.isDown("left") or love.keyboard.isDown("a")
	local right = love.keyboard.isDown("right") or love.keyboard.isDown("d")

	--Move the player in the corresponding direction
	if left then
		jpm.players[1]:move("left", dt, 1)
	end
	if right then
		jpm.players[1]:move("right", dt, 1)
	end
	--If the player presses both keys or neither, idle the player
	if left and right then
		jpm.players[1]:idle()
	end
	if not left and not right then
		jpm.players[1]:idle()
	end
end

function jpm.controls.controller(dt)
	--This is set up for the buttons on a Logitech Cordless Rumblepad 2
	--Make the game close with button 9 (select button position)
	if love.joystick.isDown(1, 9) then
		love.event.push("quit")
	end

	--Define what the left and right keys are to avoid idle animation conflicts
	local left = love.keyboard.isDown("left") or love.keyboard.isDown("a")
	local right = love.keyboard.isDown("right") or love.keyboard.isDown("d")
	--Define what the axis is (left stick)
	local axis = love.joystick.getAxis(1, 1)

	--Move the character a certain amount depending on the amount the stick is moved
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