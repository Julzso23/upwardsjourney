jpm.effects = {}

jpm.effects.background = {}
function jpm.effects.background.init()
	--Load in the sky image for the background
	jpm.effects.background.image = love.graphics.newImage("resources/images/effects/background.png")
	--Position the bottom of the image with the bottom of the screen
	jpm.effects.background.y = -602
end

function jpm.effects.background.update(dt)
	--Move the image down the screen until it has to loop, then move it back up
	if jpm.effects.background.y < -2 then
		jpm.effects.background.y = jpm.effects.background.y + 100*dt
	else
		jpm.effects.background.y = -602
	end
end
function jpm.effects.background.draw()
	--Draw the background on the screen
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(jpm.effects.background.image, 0, jpm.screen.y(jpm.effects.background.y), 0, jpm.screen.x(0.078125), jpm.screen.y(0.1388888888888888888888888))
end