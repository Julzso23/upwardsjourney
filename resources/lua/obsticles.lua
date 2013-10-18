jpm.obsticles = {}
jpm.obsticles.__index = jpm.obsticles

jpm.objects = {}

jpm.obsticles.timer = 0
jpm.obsticles.pick = 0

function jpm.obsticles.newObject()
	local o = {}
	setmetatable(o, jpm.obsticles)

	o.x = 0
	o.y = -18
	o.size = 10
	o.act = false
	o.spd = 150

	return o
end

function jpm.obsticles.generate()
	local count = 0
	while count <= 10 do
		count = count + 1
		table.insert(jpm.objects, jpm.obsticles.newObject())
	end
end
function jpm.obsticles.randomise(dt)
	if jpm.obsticles.timer > 0.75 then
		jpm.obsticles.timer = 0
		jpm.obsticles.pick = math.random(1, 10)
		for k, v in pairs(jpm.objects) do
			if k == jpm.obsticles.pick then
				v:fall()
			end
		end
	else
		jpm.obsticles.timer = jpm.obsticles.timer + dt
	end
end

function jpm.obsticles:fall()
	self.act = true
end

function jpm.obsticles:update(key, dt)
	self.x = (key-1)*10
	if self.act then
		if self.y <= 100 then
			self.y = self.y + self.spd*dt
		else
			self.act = false
			self.y = -18
		end
	end
end

function jpm.obsticles:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", jpm.screen.x(self.x), jpm.screen.y(self.y), jpm.screen.x(self.size), jpm.screen.x(self.size))
end