jpm.menu = {}

jpm.menu.buttonImg = love.graphics.newImage("resources/images/menu/button.png")

jpm.menu.id = 1

jpm.menu.main = {
	{"Play", function() jpm.core.paused = false end},
	{"Options", function() jpm.menu.cur = jpm.menu.options end},
	{"Exit", function() love.event.quit() end}
}
jpm.menu.options = {
	{"Video", function() jpm.menu.cur = jpm.menu.options_video end},
	{"Volume", function() jpm.menu.cur = jpm.menu.options_vol end},
	{"Change tune", function() jpm.music.current:stop() end},
	{"Back", function() jpm.menu.cur = jpm.menu.main jpm.core.saveOptions() end}
}
	jpm.menu.options_video = {
		{"Resolution", function() jpm.menu.cur = jpm.menu.options_video_res end},
		{"Fullscreen", function() jpm.screen.setOption("full") end},
		{"Vsync", function() jpm.screen.setOption("vsync") end},
		{"Back", function() jpm.menu.cur = jpm.menu.options end}
	}
		jpm.menu.options_video_res = {
			{"640 x 360", function() jpm.screen.setOption("res", {640, 360}) end},
			{"854 x 480", function() jpm.screen.setOption("res", {854, 480}) end},
			{"960 x 540", function() jpm.screen.setOption("res", {960, 540}) end},
			{"1024 x 576", function() jpm.screen.setOption("res", {1024, 576}) end},
			{"1280 x 720", function() jpm.screen.setOption("res", {1280, 720}) end},
			{"1366 x 768", function() jpm.screen.setOption("res", {1366, 768}) end},
			{"1600 x 900", function() jpm.screen.setOption("res", {1600, 900}) end},
			{"1920 x 1080", function() jpm.screen.setOption("res", {1920, 1080}) end},
			{"Back", function() jpm.menu.cur = jpm.menu.options_video end}
		}
		
	jpm.menu.options_vol = {
		{"0%", function() love.audio.setVolume(0) end},
		{"10%", function() love.audio.setVolume(0.1) end},
		{"20%", function() love.audio.setVolume(0.2) end},
		{"30%", function() love.audio.setVolume(00.3) end},
		{"40%", function() love.audio.setVolume(0.4) end},
		{"50%", function() love.audio.setVolume(0.5) end},
		{"60%", function() love.audio.setVolume(0.6) end},
		{"70%", function() love.audio.setVolume(0.7) end},
		{"80%", function() love.audio.setVolume(0.8) end},
		{"90%", function() love.audio.setVolume(0.9) end},
		{"100%", function() love.audio.setVolume(1) end},
		{"Back", function() jpm.menu.cur = jpm.menu.options end}
	}

jpm.menu.cur = jpm.menu.main

jpm.menu.direction = ""
jpm.menu.position = 1
jpm.menu.speed = 4

function jpm.menu.select()
	if jpm.menu.position == math.floor(jpm.menu.position) then
		jpm.screen.init()
		jpm.menu.cur[jpm.menu.id][2]()
		jpm.screen.init()
		jpm.menu.id = 1
		jpm.menu.position = 1
	end
end
function jpm.menu.back()
	jpm.menu.id = 1
	jpm.menu.position = 1
	jpm.menu.cur = jpm.menu.main
	jpm.screen.init()
	jpm.core.saveOptions()
end

function jpm.menu.press(type, pressed)
	if type == "key" then
		if pressed == "escape" then
			jpm.menu.back()
		end
		if pressed == "return" then
			jpm.menu.select()
		end
	elseif type == "joy" then
		if pressed == "b" then
			jpm.menu.back()
		end
		if pressed == "a" then
			jpm.menu.select()
		end
	end
end

function jpm.menu.animate(dt)
	if jpm.menu.direction == "left" then
		if jpm.menu.position >= jpm.menu.id then
			jpm.menu.position = jpm.menu.position - jpm.menu.speed*dt
		else
			jpm.menu.position = jpm.menu.id
			jpm.menu.direction = ""
		end
	elseif jpm.menu.direction == "right" then
		if jpm.menu.position <= jpm.menu.id then
			jpm.menu.position = jpm.menu.position + jpm.menu.speed*dt
		else
			jpm.menu.position = jpm.menu.id
			jpm.menu.direction = ""
		end
	end
end

function jpm.menu.draw()
	for k, v in pairs(jpm.menu.cur) do
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(jpm.menu.buttonImg, jpm.screen.x(25-((jpm.menu.position-1)*60)+((k-1)*60)), jpm.screen.y(25), 0, jpm.screen.y(0.092593), jpm.screen.y(0.092593))

		love.graphics.setColor(0, 0, 0, 255)
		love.graphics.printf(v[1], jpm.screen.x(25-((jpm.menu.position-1)*60)+((k-1)*60)), jpm.screen.y(28), jpm.screen.x(50), "center")
	end
end