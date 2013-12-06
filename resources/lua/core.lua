jpm.core = {}

jpm.core.paused = true

function string.explode(str, div)
	assert(type(str) == "string" and type(div) == "string", "invalid arguments")
	local o = {}
	while true do
		local pos1,pos2 = str:find(div)
		if not pos1 then
			o[#o+1] = str
			break
		end
		o[#o+1],str = str:sub(1,pos1-1),str:sub(pos2+1)
	end
	return o
end

function tobool(v)
	return v and ( (type(v)=="number") and (v==1) or ( (type(v)=="string") and (v=="true") ) )
end

function jpm.core.saveOptions()
	if not love.filesystem.exists("saves") then
		love.filesystem.mkdir("saves")
	end

	local width, height, fullscreen, vsync, fsaa = love.graphics.getMode()
	local volume = love.audio.getVolume()
	love.filesystem.write("saves/options.ujf", tostring(width) ..":".. tostring(height) ..":".. tostring(fullscreen) ..":".. tostring(vsync) ..":".. tostring(fsaa) ..":".. tostring(volume))
end

function jpm.core.loadOptions()
	if not love.filesystem.exists("saves") then
		love.filesystem.mkdir("saves")
	else
		if love.filesystem.exists("saves/options.ujf") then
			local readings = love.filesystem.read("saves/options.ujf")
			readings = string.explode(readings, ":")
			local width, height, fullscreen, vsync, fsaa, volume = readings[1], readings[2], readings[3], readings[4], readings[5], readings[6]
			love.graphics.setMode(tonumber(width), tonumber(height), tobool(fullscreen), tobool(vsync), tonumber(fsaa))
			jpm.screen.init()
			love.audio.setVolume(tonumber(volume))
		end
	end
end