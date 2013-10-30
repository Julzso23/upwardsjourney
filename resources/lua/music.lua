jpm.music = {}

function jpm.music.init()
	if not love.filesystem.exists("music") then
		love.filesystem.mkdir("music")
	end
	jpm.music.userFiles = love.filesystem.enumerate("music")
	jpm.music.userMusic = {}
	for k, v in pairs(jpm.music.userFiles) do
		if love.filesystem.isFile("music/"..v) then
			table.insert(jpm.music.userMusic, "music/"..v)
		end
	end
	
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