jpm.menu = {}

jpm.menu.buttonImg = love.graphics.newImage("resources/images/menu/button.png")

jpm.menu.id = 1
jpm.menu.main = {
	{"Play", function() jpm.core.paused = false end},
	{"Options", function() jpm.menu.cur = jpm.menu.options end},
	{"Exit", function() love.event.quit() end}
}
jpm.menu.options = {
	{"Resolution", function() jpm.menu.cur = jpm.menu.options_res end},
	{"Fullscreen", function() love.window.setMode(jpm.screen.w, jpm.screen.h, {fullscreen = not jpm.screen.f}) end},
	{"Volume", function() jpm.menu.cur = jpm.menu.options_vol end},
	{"Back", function() jpm.menu.cur = jpm.menu.main jpm.core.saveOptions() end}
}
	jpm.menu.options_res = {
		{"1024 x 576", function() love.window.setMode(1024, 576, {fullscreen = jpm.screen.f}) end},
		{"1280 x 720", function() love.window.setMode(1280, 720, {fullscreen = jpm.screen.f}) end},
		{"1600 x 900", function() love.window.setMode(1600, 900, {fullscreen = jpm.screen.f}) end},
		{"1920 x 1080", function() love.window.setMode(1920, 1080, {fullscreen = jpm.screen.f}) end},
		{"Back", function() jpm.menu.cur = jpm.menu.options end}
	}
	jpm.menu.options_vol = {
		{"0%", function() love.audio.setVolume(0) end},
		{"20%", function() love.audio.setVolume(0.2) end},
		{"40%", function() love.audio.setVolume(0.4) end},
		{"60%", function() love.audio.setVolume(0.6) end},
		{"80%", function() love.audio.setVolume(0.8) end},
		{"100%", function() love.audio.setVolume(1) end},
		{"Back", function() jpm.menu.cur = jpm.menu.options end}
	}

jpm.menu.cur = jpm.menu.main

function jpm.menu.press(type, pressed)
	if type == "key" then
		if pressed == "escape" then
			jpm.menu.id = 1
			jpm.menu.cur = jpm.menu.main
			jpm.screen.init()
			jpm.core.saveOptions()
		end
		if pressed == "return" then
			jpm.screen.init()
			jpm.menu.cur[jpm.menu.id][2]()
			jpm.screen.init()
			jpm.menu.id = 1
		end
	elseif type == "joy" then
		if pressed == "b" then
			jpm.menu.id = 1
			jpm.menu.cur = jpm.menu.main
			jpm.screen.init()
			jpm.core.saveOptions()
		end
		if pressed == "a" then
			jpm.screen.init()
			jpm.menu.cur[jpm.menu.id][2]()
			jpm.screen.init()
			jpm.menu.id = 1
		end
	end
end

function jpm.menu.draw()
	for k, v in pairs(jpm.menu.cur) do
		if jpm.menu.id == k then
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.draw(jpm.menu.buttonImg, jpm.screen.x(25), jpm.screen.y(10), 0, jpm.screen.y(0.092593), jpm.screen.y(0.092593))

			love.graphics.setColor(0, 0, 0, 255)
			love.graphics.printf(v[1], jpm.screen.x(25), jpm.screen.y(13), jpm.screen.x(50), "center")
		end
	end
end