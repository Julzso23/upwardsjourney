jpm.effects = {}

jpm.effects.background = {}
function jpm.effects.background.init()
	jpm.effects.background.image = love.graphics.newImage("resources/images/effects/background.png")
	jpm.effects.background.y = -600
end

function jpm.effects.background.update(dt)
	if jpm.effects.background.y < 0 then
		jpm.effects.background.y = jpm.effects.background.y + 100*dt
	else
		jpm.effects.background.y = -600
	end
end
function jpm.effects.background.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(jpm.effects.background.image, 0, jpm.screen.y(jpm.effects.background.y), 0, jpm.screen.x(0.078125), jpm.screen.y(0.139))
end