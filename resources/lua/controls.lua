jpm.controls = {}
jpm.controls.delay = 0.3
jpm.controls.timer = jpm.controls.delay

function jpm.controls.keyboard(dt)
	if jpm.controls.timer < 0.5 then
		jpm.controls.timer = jpm.controls.timer + dt
	end

	--Make the game close with alt+f4
	if love.keyboard.isDown("lalt") and love.keyboard.isDown("f4") then
		love.event.push("quit")
	end

	--Define what the left and right keys are
	local left = love.keyboard.isDown("left") or love.keyboard.isDown("a")
	local right = love.keyboard.isDown("right") or love.keyboard.isDown("d")

	if not jpm.core.paused then
		if love.keyboard.isDown("escape") then
			jpm.core.paused = true
		end

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
	else
		if jpm.controls.timer >= jpm.controls.delay then
			if left then
				jpm.controls.timer = 0
				if jpm.menu.id > 1 then
					jpm.menu.id = jpm.menu.id - 1
				else
					jpm.menu.id = #jpm.menu.cur
				end
			end
			if right then
				jpm.controls.timer = 0
				if jpm.menu.id < #jpm.menu.cur then
					jpm.menu.id = jpm.menu.id + 1
				else
					jpm.menu.id = 1
				end
			end
		end
	end
end

function jpm.controls.controller(dt)
	--This is set up for the buttons on a Logitech Cordless Rumblepad 2

	--Define what the left and right keys are to avoid idle animation conflicts
	local left = love.keyboard.isDown("left") or love.keyboard.isDown("a")
	local right = love.keyboard.isDown("right") or love.keyboard.isDown("d")
	--Define what the axis is (left stick)
	local axis = love.joystick.getAxis(1, 1)

	if not jpm.core.paused then
		if love.joystick.isDown(1, 10) then
			jpm.core.paused = true
		end

		--Move the character a certain amount depending on the amount the stick is moved
		if axis < -0.03 then
			jpm.players[1]:move("left", dt, -axis)
		end
		if axis > 0.03 then
			jpm.players[1]:move("right", dt, axis)
		end
		if axis > -0.03 and axis < 0.03 and not left and not right then
			jpm.players[1]:idle()
		end
	else
		if jpm.controls.timer >= jpm.controls.delay then
			if axis < -0.1 then
				jpm.controls.timer = 0
				if jpm.menu.id > 1 then
					jpm.menu.id = jpm.menu.id - 1
				else
					jpm.menu.id = #jpm.menu.cur
				end
			end
			if axis > 0.1 then
				jpm.controls.timer = 0
				if jpm.menu.id < #jpm.menu.cur then
					jpm.menu.id = jpm.menu.id + 1
				else
					jpm.menu.id = 1
				end
			end
		end
	end
end