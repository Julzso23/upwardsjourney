jpm.gui = {}
jpm.gui.__index = jpm.gui


function jpm.gui.newButton(text, x, y, w, h)
	local g = {}
	setmetatable(g, jpm.gui)

	g.text = text
	g.x = x
	g.y = y
	g.w = w
	g.h = h

	return g
end

function jpm.gui:onClicked(x, y, button)
	if button == "l" then
	end
end