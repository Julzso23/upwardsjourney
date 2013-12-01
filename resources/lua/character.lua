jpm.players = {}

jpm.char = {}
jpm.char.__index = jpm.char

--For adding new players
function jpm.char.newPlayer()
	local p = {}
	setmetatable(p, jpm.char)

	p.x = 50
	p.y = 85
	p.r = 0
	p.scale = {0.059, 0.104}
	p.spd = 75
	p.img = {
		--Define images for animating
		current = nil,
		idle = love.graphics.newImage("resources/images/characters/main/unhappy1.png"),
		left = love.graphics.newImage("resources/images/characters/main/unhappy1.png"),
		right = love.graphics.newImage("resources/images/characters/main/unhappy1.png")
	}
	--Some values for collision box sizing
	p.w = 3.1
	p.b = 6.9
	p.t = 11

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
	self.y = pos
end

--Move a certain amount in a specified direction
function jpm.char:move(dir, dt, amount)
	if dir == "left" then
		if self.x > 2.8 then
			self.x = self.x - ((self.spd*amount)*dt) --*dt means per second
			self.img.current = self.img.left
			self.r = -amount/2

			jpm.particles.fire:setPosition(jpm.screen.x(jpm.players[1]:getX()+amount*0.75+1), jpm.screen.y(jpm.players[1]:getY()-amount*2+8))
		else
			self.x = 2.8
			self:idle()
		end
	end
	if dir == "right" then
		if self.x < 97.2 then
			self.x = self.x + ((self.spd*amount)*dt)
			self.img.current = self.img.right
			self.r = amount/2

			jpm.particles.fire:setPosition(jpm.screen.x(jpm.players[1]:getX()-amount*1.25+1), jpm.screen.y(jpm.players[1]:getY()-amount*2+8))
		else
			self.x = 97.2
			self:idle()
		end
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
	self.r = 0

	jpm.particles.fire:setPosition(jpm.screen.x(jpm.players[1]:getX()+1), jpm.screen.y(jpm.players[1]:getY()+8))
end

function jpm.char:getSpd()
	return self.spd
end
function jpm.char:setSpd(s)
	self.spd = s
end

function jpm.char:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.img.current, jpm.screen.x(self.x), jpm.screen.y(self.y), self.r, jpm.screen.x(self.scale[1]), jpm.screen.y(self.scale[2]), 60, 125)
end

function jpm.char:checkCollisions(dt)
	if self.y > 65 then
		self:move("up", dt, 0.025)
	end
	for k, v in pairs(jpm.objects) do
		if self.x+self.w > v.x and self.x-self.w < v.x+v.size then
			if self.y+self.b > v.y and self.y-self.t < v.y+v.size then
				self:onHit(dt)
			end
		end
	end
end

function jpm.char:onHit(dt)
	self:move("down", dt, 1.5)
	if self.y > 100 then
		self:setX(50)
		self:setY(85)
	end
end