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

	--Record the screen size for game scaling
	jpm.screen.init()

	--Make the player
	table.insert(jpm.players, jpm.char.newPlayer())

	--Make the falling obsticles
	jpm.obsticles.generate()

	jpm.music.init()

	jpm.effects.background.init()

	jpm.particles.init()

	--Add the logo
	logo = love.graphics.newImage("resources/images/other/Upwards Journey.png")

	--Make the background white
	love.graphics.setBackgroundColor(255, 255, 255)
end

function love.update(dt)
	jpm.music.update()
	
	jpm.effects.background.update(dt)

	jpm.controls.keyboard(dt)
	jpm.controls.controller(dt)

	--Pick a random obsticle to fall
	jpm.obsticles.randomise(dt)

	--Make the obsticles fall
	for k, v in pairs(jpm.objects) do
		v:update(k, dt)
	end
	
	--Check for collisions with the player(s)
	for k, v in pairs(jpm.players) do
		v:checkCollisions(dt)
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

	--Put the logo on the screen
	love.graphics.draw(logo, jpm.screen.x(50), 0, 0, 0.4, 0.4, 512, 0)
end