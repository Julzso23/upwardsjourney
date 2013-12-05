jpm = {}

function love.load()
	--Include all teh files
	require("resources/lua/core")
	require("resources/lua/character")
	require("resources/lua/controls")
	require("resources/lua/obsticles")
	require("resources/lua/screen")
	require("resources/lua/gui")
	require("resources/lua/music")
	require("resources/lua/effects")
	require("resources/lua/particles")
	require("resources/lua/hud")
	require("resources/lua/menus")

	--Record the screen size for game scaling
	jpm.screen.init()

	--Make the player
	table.insert(jpm.players, jpm.char.newPlayer())

	--Make the falling obsticles
	jpm.obsticles.generate()

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

	if not jpm.core.paused then
		if jpm.obsticles.started then
			--Pick a random obsticle to fall
			jpm.obsticles.randomise(dt)

			--Make the obsticles fall
			for k, v in pairs(jpm.objects) do
				v:update(k, dt)
			end
		end
	
		--Check for collisions with the player(s)
		for k, v in pairs(jpm.players) do
			v:checkCollisions(dt)
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

	--Draw all the obsticles
	for k, v in pairs(jpm.objects) do
		v:draw()
	end

	if not jpm.core.paused then
		jpm.hud.draw()
	end

	if jpm.core.paused then
		jpm.menu.draw()
	end
end

function love.keyreleased(key)
	if jpm.core.paused then
		jpm.menu.press("key", key)
	end
end

function love.joystickreleased(joystick, button)
	if jpm.core.paused then
		jpm.menu.press("joy", button)
	end
end