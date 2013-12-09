jpm.screen = {}

function jpm.screen.init()
	jpm.screen.w, jpm.screen.h, jpm.screen.f = love.graphics.getMode()
end

--Convert a percentage to a position/size depending on screen size
function jpm.screen.x(pos)
	return (pos/100)*jpm.screen.w
end

function jpm.screen.y(pos)
	return (pos/100)*jpm.screen.h
end