jpm.screen = {}

function jpm.screen.x(pos)
	return (pos/100)*love.graphics.getWidth()
end

function jpm.screen.y(pos)
	return (pos/100)*love.graphics.getHeight()
end