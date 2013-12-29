jpm.controls = {}
jpm.controls.delay = 0.3
jpm.controls.timer = jpm.controls.delay

function jpm.controls.keyboard(dt)
	if jpm.controls.timer < 0.5 then
		jpm.controls.timer = jpm.controls.timer + dt
	end

	--Make the game close with alt+f4
	if love.keyboard.isDown("lalt") and love.keyboard.isDown("f4") then
		love.event.quit()
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
					jpm.menu.direction = "left"
				else
					jpm.menu.id = #jpm.menu.cur
					jpm.menu.direction = "right"
				end
			end
			if right then
				jpm.controls.timer = 0
				if jpm.menu.id < #jpm.menu.cur then
					jpm.menu.id = jpm.menu.id + 1
					jpm.menu.direction = "right"
				else
					jpm.menu.id = 1
					jpm.menu.direction = "left"
				end
			end
		end
	end
end

function jpm.controls.controller(dt)
	--This is set up for the buttons on an Xbox360 gamepad

	--Define what the left and right keys are to avoid idle animation conflicts
	local left = love.keyboard.isDown("left") or love.keyboard.isDown("a")
	local right = love.keyboard.isDown("right") or love.keyboard.isDown("d")

	if #love.joystick.getJoysticks() >= 1 then
		local gamepad = love.joystick.getJoysticks()[1]
		local axis = gamepad:getGamepadAxis("leftx")

		if not jpm.core.paused then
			if gamepad:isGamepadDown("start") then
				jpm.core.paused = true
			end

			--Move the character a certain amount depending on the amount the stick is moved
			if axis < -0.15 then
				jpm.players[1]:move("left", dt, -axis)
			end
			if axis > 0.15 then
				jpm.players[1]:move("right", dt, axis)
			end
			if axis > -0.15 and axis < 0.15 and not left and not right then
				jpm.players[1]:idle()
			end
		else
			if jpm.controls.timer >= jpm.controls.delay then
				if axis < -0.4 then
					jpm.controls.timer = 0
					if jpm.menu.id > 1 then
						jpm.menu.id = jpm.menu.id - 1
						jpm.menu.direction = "left"
					else
						jpm.menu.id = #jpm.menu.cur
						jpm.menu.direction = "right"
					end
				end
				if axis > 0.4 then
					jpm.controls.timer = 0
					if jpm.menu.id < #jpm.menu.cur then
						jpm.menu.id = jpm.menu.id + 1
						jpm.menu.direction = "right"
					else
						jpm.menu.id = 1
						jpm.menu.direction = "left"
					end
				end
			end
		end
	end
end