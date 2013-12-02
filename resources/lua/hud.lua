jpm.hud = {}

function jpm.hud.init()
	jpm.hud.logo = love.graphics.newImage("resources/images/other/Upwards Journey.png")
	jpm.hud.font = love.graphics.newFont("resources/fonts/CD_B.ttf", 20)
	love.graphics.setFont(jpm.hud.font)
end

function jpm.hud.update()
end

function jpm.hud.draw()
	love.graphics.print("WASD or arrow keys to move", 5, 5)

	love.graphics.draw(jpm.hud.logo, jpm.screen.x(50), 0, 0, 0.4, 0.4, 512, 0)

	if not jpm.obsticles.started then
		love.graphics.printf("YOU HAVE "..math.floor(jpm.obsticles.startTimer).." SECONDS", jpm.screen.x(25), jpm.screen.y(50), jpm.screen.x(50), "center" )
	end
end