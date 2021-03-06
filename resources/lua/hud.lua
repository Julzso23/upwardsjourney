jpm.hud = {}

function jpm.hud.init()
	jpm.hud.logo = love.graphics.newImage("resources/images/other/Upwards Journey.png")
	jpm.hud.font = love.graphics.newFont("resources/fonts/CD_B.ttf", 30)
	love.graphics.setFont(jpm.hud.font)
end

function jpm.hud.update()
end

function jpm.hud.draw()
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.print("WASD or arrow keys to move", jpm.screen.x(1), jpm.screen.y(1))

	for k, v in pairs(jpm.players) do
		love.graphics.setColor(0, 0, 0, 255)
		love.graphics.printf("Score: "..math.floor(v.score), jpm.screen.x(79), jpm.screen.y(1), jpm.screen.x(20), "right")

		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.rectangle("fill", jpm.screen.x(98.5), jpm.screen.y(100-(jpm.players[1].boost/8)), jpm.screen.x(1), jpm.screen.y(jpm.players[1].boost/8))

		if v.dead and not jpm.core.paused then
			love.graphics.setColor(0, 0, 0, 255)
			love.graphics.printf("YOU HAVE DIED", jpm.screen.x(25), jpm.screen.y(40), jpm.screen.x(50), "center" )
		end
	end

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(jpm.hud.logo, jpm.screen.x(50), 0, 0, 0.4, 0.4, 512, 0)

	if not jpm.obsticles.started and not jpm.core.paused then
		love.graphics.setColor(0, 0, 0, 255)
		love.graphics.printf("YOU HAVE ".. math.floor(jpm.obsticles.startTimer)+1 .." SECONDS", jpm.screen.x(25), jpm.screen.y(50), jpm.screen.x(50), "center" )
	end
end