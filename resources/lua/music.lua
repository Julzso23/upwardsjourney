jpm.music = {}

function jpm.music.init()
	jpm.music.current = love.audio.newSource("resources/audio/"..math.random(1,5)..".mp3", "stream")
	jpm.music.current:play()
end

function jpm.music.update()
	if jpm.music.current:isStopped() then
		jpm.music.current = love.audio.newSource("resources/audio/"..math.random(1,5)..".mp3", "stream")
		jpm.music.current:play()
	end
end