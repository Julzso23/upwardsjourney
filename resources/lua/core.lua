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

	local width, height, flags = love.window.getMode()
	local volume = love.audio.getVolume()
	love.filesystem.write("saves/options.ujf", tostring(width) ..":".. tostring(height) ..":".. tostring(flags.fullscreen) ..":".. tostring(flags.vsync) ..":".. tostring(flags.fsaa) ..":".. tostring(volume))
end
function jpm.core.loadOptions()
	if not love.filesystem.exists("saves") then
		love.filesystem.createDirectory("saves")
	else
		if love.filesystem.exists("saves/options.ujf") then
			local readings = love.filesystem.read("saves/options.ujf")
			readings = string.explode(readings, ":")
			local width, height, fullscreen, vsync, fsaa, volume = readings[1], readings[2], readings[3], readings[4], readings[5], readings[6]
			love.window.setMode(tonumber(width), tonumber(height), {fullscreen = tobool(fullscreen), vsync = tobool(vsync), fsaa = tonumber(fsaa)})
			jpm.screen.init()
			love.audio.setVolume(tonumber(volume))
		end
	end
end

function jpm.core.savePlayer()
	if not love.filesystem.exists("saves") then
		love.filesystem.mkdir("saves")
	end

	local score = jpm.players[1].score
	love.filesystem.write("saves/player1.ujf", tostring(score) ..":")
	print("Saving player1")
end
function jpm.core.loadPlayer()
	if not love.filesystem.exists("saves") then
		love.filesystem.createDirectory("saves")
	else
		if love.filesystem.exists("saves/player1.ujf") then
			local readings = love.filesystem.read("saves/player1.ujf")
			readings = string.explode(readings, ":")
			local score = tonumber(readings[1])
			jpm.players[1].score = score
		end
	end
end