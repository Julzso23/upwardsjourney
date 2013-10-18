jpm = {}

function love.load()
	require("resources/lua/character")
	require("resources/lua/obsticles")
	require("resources/lua/screen")
	require("resources/lua/gui")
	require("resources/lua/music")

	table.insert(jpm.players, jpm.char.newPlayer())
	table.insert(jpm.players, jpm.char.newPlayer())

	jpm.obsticles.generate()

	jpm.music.init()

	love.graphics.setBackgroundColor(255, 255, 255)
end

function love.update(dt)
	jpm.music.update()

	if love.keyboard.isDown("left") then
		jpm.players[1]:move("left", dt)
	end
	if love.keyboard.isDown("right") then
		jpm.players[1]:move("right", dt)
	end

	if love.keyboard.isDown("a") then
		jpm.players[2]:move("left", dt)
	end
	if love.keyboard.isDown("d") then
		jpm.players[2]:move("right", dt)
	end

	jpm.obsticles.randomise(dt)

	for k, v in pairs(jpm.objects) do
		v:update(k, dt)
	end
end

function love.draw()
	for k, v in pairs(jpm.players) do
		v:draw()
	end
	for k, v in pairs(jpm.objects) do
		v:draw()
	end
end