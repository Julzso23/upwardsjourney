jpm.pickups = {}
jpm.pickups.__index = jpm.pickups

jpm.items = {}

jpm.pickups.timer = 0

--For making new pickups
function jpm.pickups.newPickup(x)
	local o = {}
	setmetatable(o, jpm.pickups)

	o.x = x
	o.y = -18
	o.size = 10
	o.spd = 100

	return o
end

function jpm.pickups.reset()
	jpm.items = {}
	jpm.pickups.timer = 0
end

--Randomly pick an pickup to fall every 0.25 of a second
function jpm.pickups.randomise(dt)
	if jpm.pickups.timer > 1 then
		jpm.pickups.timer = 0
		table.insert(jpm.items, jpm.pickups.newPickup(math.random(2, 7)*10))
	else
		jpm.pickups.timer = jpm.pickups.timer + dt
	end
end

function jpm.pickups:remove(key)
	table.remove(jpm.items, key)
end

function jpm.pickups:update(key, dt)
	if self.y <= 100 then
		self.y = self.y + self.spd*dt
	else
		self:remove(key)
	end
end

--Draw the pickup on the screen for you to see
function jpm.pickups:draw()
	love.graphics.setColor(150, 150, 150)
	love.graphics.rectangle("fill", jpm.screen.x(self.x), jpm.screen.y(self.y), jpm.screen.x(self.size), jpm.screen.x(self.size))
end