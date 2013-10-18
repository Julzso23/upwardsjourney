jpm.gui = {}
jpm.gui.__index = jpm.gui

function jpm.gui.newButton(x, y, w, h)
	local g = {}
	setmetatable(g, jpm.gui)

	g.x = jpm.screen.x(x)
	g.y = jpm.screen.y(y)
	g.w = jpm.screen.x(w)
	g.h = jpm.screen.x(h)

	return g
end

function jpm.gui:onClick(x, y, button)
	if button == "l" then
	end
end