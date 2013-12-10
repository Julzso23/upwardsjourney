jpm.screen = {}

function jpm.screen.init()
	jpm.screen.w, jpm.screen.h, jpm.screen.flags = love.window.getMode()
	jpm.screen.f = jpm.screen.flags.fullscreen
end

--Convert a percentage to a position/size depending on screen size
function jpm.screen.x(pos)
	return (pos/100)*jpm.screen.w
end

function jpm.screen.y(pos)
	return (pos/100)*jpm.screen.h
end