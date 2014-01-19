jpm = {}

function string.explode(str, div)
	assert(type(str) == "string" and type(div) == "string", "invalid arguments")
	local o = {}
	while true do
		local pos1,pos2 = str:find(div)
		if not pos1 then
			o[#o+1] = str
			break
		end
		o[#o+1],str = str:sub(1,pos1-1),str:sub(pos2+1)
	end
	return o
end

function love.load()
	--Include all teh files
	for k, v in pairs(love.filesystem.getDirectoryItems("resources/lua")) do
		require("resources/lua/"..string.gsub(v, ".lua", ""))
	end

	jpm.core.loadOptions()

	--Record the screen size for game scaling
	jpm.screen.init()

	jpm.char.init()
	jpm.core.loadPlayer()

	jpm.music.init()

	jpm.effects.background.init()

	jpm.particles.init()

	jpm.hud.init()

	--Make the background white
	love.graphics.setBackgroundColor(255, 255, 255)
end

function love.update(dt)
	jpm.music.update()
	
	jpm.effects.background.update(dt)

	jpm.controls.keyboard(dt)
	jpm.controls.controller(dt)

	jpm.menu.animate(dt)

	if not jpm.core.paused then
		if jpm.obsticles.started then
			--Pick a random obsticle to fall
			jpm.obsticles.randomise(dt)
			jpm.pickups.randomise(dt)

			--Make the obsticles fall
			for k, v in pairs(jpm.objects) do
				v:update(k, dt)
			end
			for k, v in pairs(jpm.items) do
				v:update(k, dt)
			end
		end
	
		--Check for collisions with the player(s)
		for k, v in pairs(jpm.players) do
			if not v.dead then
				v:checkCollisions(dt)
			end
			v:update(dt)
		end

		jpm.obsticles.countDown(dt)
	end

	jpm.particles.update(dt)
end

function love.draw()
	jpm.effects.background.draw()

	jpm.particles.draw()
	--Draw all player(s)
	for k, v in pairs(jpm.players) do
		v:draw()
	end

	for k, v in pairs(jpm.items) do
		v:draw()
	end
	--Draw all the obsticles
	for k, v in pairs(jpm.objects) do
		v:draw()
	end

	jpm.hud.draw()

	if jpm.core.paused then
		jpm.menu.draw()
	end
end

function love.keyreleased(key)
	if jpm.core.paused then
		jpm.menu.press("key", key)
	end
end

function love.gamepadreleased( joystick, button )
	if jpm.core.paused then
		jpm.menu.press("joy", button)
	end
end

function love.resize(w, h)
	jpm.screen.init()
end

function love.joystickadded(joystick)
	print("Joystick \""..joystick:getName().."\" added!")
end
function love.joystickremoved(joystick)
	print("Joystick \""..joystick:getName().."\" removed!")
end