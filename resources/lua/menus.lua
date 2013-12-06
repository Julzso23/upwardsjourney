jpm.menu = {}

jpm.menu.id = 1
jpm.menu.main = {
	{"Play", function() jpm.core.paused = false end},
	{"Options", function() jpm.menu.cur = jpm.menu.options end},
	{"Exit", function() love.event.push("quit") end}
}
jpm.menu.options = {
	{"Resolution", function() jpm.menu.cur = jpm.menu.options_res end},
	{"Volume", function() jpm.menu.cur = jpm.menu.options_vol end},
	{"Back", function() jpm.menu.cur = jpm.menu.main jpm.core.saveOptions() end}
}
	jpm.menu.options_res = {
		{"1024 x 576", function() love.graphics.setMode(1024, 576) jpm.screen.init() end},
		{"1280 x 720", function() love.graphics.setMode(1280, 720) jpm.screen.init() end},
		{"1600 x 900", function() love.graphics.setMode(1600, 900) jpm.screen.init() end},
		{"1920 x 1080", function() love.graphics.setMode(1920, 1080) jpm.screen.init() end},
		{"Back", function() jpm.menu.cur = jpm.menu.main end}
	}
	jpm.menu.options_vol = {
		{"0%", function() love.audio.setVolume(0) end},
		{"20%", function() love.audio.setVolume(0.2) end},
		{"40%", function() love.audio.setVolume(0.4) end},
		{"60%", function() love.audio.setVolume(0.6) end},
		{"80%", function() love.audio.setVolume(0.8) end},
		{"100%", function() love.audio.setVolume(1) end},
		{"Back", function() jpm.menu.cur = jpm.menu.main end}
	}

jpm.menu.cur = jpm.menu.main

function jpm.menu.press(type, pressed)
	if type == "key" then
		if pressed == "escape" then
			jpm.menu.cur = jpm.menu.main
			jpm.core.saveOptions()
		end
		if pressed == "return" then
			jpm.menu.cur[jpm.menu.id][2]()
			jpm.menu.id = 1
		end
	elseif type == "joy" then
		if pressed == 3 then
			jpm.menu.cur = jpm.menu.main
			jpm.core.saveOptions()
		end
		if pressed == 2 then
			jpm.menu.cur[jpm.menu.id][2]()
			jpm.menu.id = 1
		end
	end
end

function jpm.menu.draw()
	for k, v in pairs(jpm.menu.cur) do
		if jpm.menu.id == k then
			love.graphics.setColor(100, 100, 100, 150)
			love.graphics.rectangle("fill", jpm.screen.x(25), jpm.screen.y(10), jpm.screen.x(50), jpm.screen.y(10))

			love.graphics.setColor(0, 0, 0, 255)
			love.graphics.printf(v[1], jpm.screen.x(25), jpm.screen.y(13), jpm.screen.x(50), "center")
		end
	end
end