jpm.screen = {}

function jpm.screen.init()
	jpm.screen.width = love.graphics.getWidth()
	jpm.screen.height = love.graphics.getHeight()
end

--Convert a percentage to a position/size depending on screen size
function jpm.screen.x(pos)
	return (pos/100)*jpm.screen.width
end

function jpm.screen.y(pos)
	return (pos/100)*jpm.screen.height
end