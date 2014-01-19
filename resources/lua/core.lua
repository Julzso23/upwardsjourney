jpm.core = {}

jpm.core.paused = true

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

	local score, time = jpm.players[1].score, jpm.players[1].time
	love.filesystem.write("saves/player1.ujf", tostring(score) ..":".. tostring(time))
end
function jpm.core.loadPlayer()
	if not love.filesystem.exists("saves") then
		love.filesystem.createDirectory("saves")
	else
		if love.filesystem.exists("saves/player1.ujf") then
			local readings = love.filesystem.read("saves/player1.ujf")
			readings = string.explode(readings, ":")
			local score, time = tonumber(readings[1]), tonumber(readings[2])
			jpm.players[1].score = score
			jpm.players[1].time = time
		end
	end
end