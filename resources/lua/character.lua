jpm.players = {}

jpm.char = {}
jpm.char.__index = jpm.char

function jpm.char.newPlayer()
	local p = {}
	setmetatable(p, jpm.char)

	p.x = 50
	p.y = 85
	p.r = 0
	p.spd = 75
	p.img = {
		current = nil,
		idle = love.graphics.newImage("resources/images/characters/main/idle.png"),
		left = love.graphics.newImage("resources/images/characters/main/left.png"),
		right = love.graphics.newImage("resources/images/characters/main/right.png")
	}

	return p
end

function jpm.char:getX()
	return self.x
end
function jpm.char:getY()
	return self.y
end
function jpm.char:setX(pos)
	self.x = pos
end
function jpm.char:setY(pos)
	self.y = jpm.screen.x(pos)
end

function jpm.char:move(dir, dt, amount)
	if dir == "left" then
		self.x = self.x - ((self.spd*amount)*dt)
		self.img.current = self.img.left
	end
	if dir == "right" then
		self.x = self.x + ((self.spd*amount)*dt)
		self.img.current = self.img.right
	end

	if dir == "up" then
		self.y = self.y - ((self.spd*amount)*dt)
	end
	if dir == "down" then
		self.y = self.y + ((self.spd*amount)*dt)
	end
end
function jpm.char:idle()
	self.img.current = self.img.idle
end

function jpm.char:getSpd()
	return self.spd
end
function jpm.char:setSpd(s)
	self.spd = s
end

function jpm.char:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.img.current, jpm.screen.x(self.x), jpm.screen.y(self.y), self.r, 0.75, 0.75, 60, 125)
end