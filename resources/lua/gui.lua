jpm.gui = {}
jpm.gui.__index = jpm.gui

--BROKEN STUFF!!!-------
function jpm.gui.newButton(text, x, y)
	local g = {}
	setmetatable(g, jpm.gui)

	g.text = text
	g.x = x
	g.y = y

	return g
end