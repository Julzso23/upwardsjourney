jpm.core = {}
jpm.core.paused = true
jpm.core.msg = require("resources/lib/MessagePack")

function tobool(v)
	return v and ( (type(v)=="number") and (v==1) or ( (type(v)=="string") and (v=="true") ) )
end

function jpm.core.saveOptions()
	if not love.filesystem.exists("saves") then
		love.filesystem.mkdir("saves")
	end

	local data = {
		width, height, flags = love.window.getMode(),
		volume = love.audio.getVolume()
	}
	
	love.filesystem.write("saves/options.ujf", jpm.core.msg.pack(data))
end
function jpm.core.loadOptions()
	if not love.filesystem.exists("saves") then
		love.filesystem.createDirectory("saves")
	else
		if love.filesystem.exists("saves/options.ujf") then
			local data = love.filesystem.read("saves/options.ujf")
			data = jpm.core.msg.unpack(data)
			love.window.setMode(data.width, data.height, data.flags)
			jpm.screen.init()
			love.audio.setVolume(data.volume)
		end
	end
end

function jpm.core.savePlayer()
	if not love.filesystem.exists("saves") then
		love.filesystem.mkdir("saves")
	end

	local data = {
		score = jpm.players[1].score,
		time = jpm.players[1].time
	}
	love.filesystem.write("saves/player1.ujf", jpm.core.msg.pack(data))
end
function jpm.core.loadPlayer()
	if not love.filesystem.exists("saves") then
		love.filesystem.createDirectory("saves")
	else
		if love.filesystem.exists("saves/player1.ujf") then
			local data = love.filesystem.read("saves/player1.ujf")
			data = jpm.core.msg.unpack(data)
			jpm.players[1].score = data.score
			jpm.players[1].time = data.time
		end
	end
end