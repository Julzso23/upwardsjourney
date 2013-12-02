jpm = {}

function love.load()
	--Include all teh files
	require("resources/lua/character")
	require("resources/lua/controls")
	require("resources/lua/obsticles")
	require("resources/lua/screen")
	require("resources/lua/gui")
	require("resources/lua/music")
	require("resources/lua/effects")
	require("resources/lua/particles")
	require("resources/lua/hud")

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

	jpm.particles.update(dt)

	jpm.obsticles.countDown(dt)
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

	jpm.hud.draw()
end