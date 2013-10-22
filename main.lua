jpm = {}

function love.load()
	require("resources/lua/character")
	require("resources/lua/controls")
	require("resources/lua/obsticles")
	require("resources/lua/screen")
	require("resources/lua/gui")
	require("resources/lua/music")
	require("resources/lua/effects")

	table.insert(jpm.players, jpm.char.newPlayer())

	jpm.obsticles.generate()

	jpm.music.init()

	jpm.effects.background.init()

	logo = love.graphics.newImage("resources/images/other/Upwards Journey.png")

	love.graphics.setBackgroundColor(255, 255, 255)
end

function love.update(dt)
	jpm.music.update()
	
	jpm.effects.background.update(dt)

	jpm.controls.keyboard(dt)
	jpm.controls.controller(dt)

	jpm.obsticles.randomise(dt)

	for k, v in pairs(jpm.objects) do
		v:update(k, dt)
	end
	
	for k, v in pairs(jpm.players) do
		v:checkCollisions(dt)
	end
end

function love.draw()
	jpm.effects.background.draw()

	for k, v in pairs(jpm.players) do
		v:draw()
	end
	for k, v in pairs(jpm.objects) do
		v:draw()
	end

	love.graphics.draw(logo, jpm.screen.x(50), 0, 0, 0.4, 0.4, 512, 0)
end