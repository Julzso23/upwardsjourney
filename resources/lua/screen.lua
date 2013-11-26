jpm.screen = {}

--Convert a percentage to a position/size depending on screen size
function jpm.screen.x(pos)
	return (pos/100)*love.graphics.getWidth()
end

function jpm.screen.y(pos)
	return (pos/100)*love.graphics.getHeight()
end