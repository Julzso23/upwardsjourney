jpm.music = {}

function jpm.music.init()
	--If there is no folder for custom music in appdata, make one
	if not love.filesystem.exists("music") then
		love.filesystem.createDirectory("music")
	end
	--Make a list of all the files in the custom music folder
	jpm.music.userFiles = love.filesystem.getDirectoryItems("music")
	jpm.music.userMusic = {}
	--Check if each object in the custom music folder is a file (not a folder etc.)
	for k, v in pairs(jpm.music.userFiles) do
		if love.filesystem.isFile("music/"..v) then
			--Add it to an array of custom music
			table.insert(jpm.music.userMusic, "music/"..v)
		end
	end
	
	love.audio.setVolume(0.25)

	--Determine if the user has any custom music to play, if not, play the default music
	if #jpm.music.userMusic > 0 then
		jpm.music.currentId = 1
		jpm.music.current = love.audio.newSource(jpm.music.userMusic[jpm.music.currentId], "stream")
		jpm.music.current:play()
	else
		jpm.music.currentId = -1
		jpm.music.current = love.audio.newSource("resources/audio/"..math.random(1,5)..".mp3", "stream")
		jpm.music.current:play()
	end
end

function jpm.music.update()
	--When the current song stops, pick a new one to play at random
	if jpm.music.current:isStopped() then
		jpm.music.current = love.audio.newSource("resources/audio/"..math.random(1,5)..".mp3", "stream")
		if jpm.music.currentId > 0 then
			if #jpm.music.userMusic > jpm.music.currentId then
				jpm.music.currentId = jpm.music.currentId + 1
				jpm.music.current = love.audio.newSource(jpm.music.userMusic[jpm.music.currentId], "stream")
			else
				jpm.music.currentId = 1
				jpm.music.current = love.audio.newSource(jpm.music.userMusic[jpm.music.currentId], "stream")
			end
		end
		jpm.music.current:play()
	end
end