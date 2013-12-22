jpm.screen = {}

function jpm.screen.init()
	love.mouse.setVisible(false)
	jpm.screen.w, jpm.screen.h, jpm.screen.flags = love.window.getMode()
	jpm.screen.f = jpm.screen.flags.fullscreen
	jpm.screen.vsync = jpm.screen.flags.vsync
end

function jpm.screen.setOption(option, value)
	if option == "res" then
		love.window.setMode(value[1], value[2], {fullscreen = jpm.screen.f, vsync = jpm.screen.vsync})
	elseif option == "full" then
		love.window.setMode(jpm.screen.w, jpm.screen.h, {fullscreen = not jpm.screen.f, vsync = jpm.screen.vsync})
	elseif option == "vsync" then
		love.window.setMode(jpm.screen.w, jpm.screen.h, {fullscreen = jpm.screen.f, vsync = not jpm.screen.vsync})
	end
end

--Convert a percentage to a position/size depending on screen size
function jpm.screen.x(pos)
	return (pos/100)*jpm.screen.w
end

function jpm.screen.y(pos)
	return (pos/100)*jpm.screen.h
end