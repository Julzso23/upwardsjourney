jpm.obsticles = {}
jpm.obsticles.__index = jpm.obsticles

jpm.objects = {}

jpm.obsticles.startTimer = 5
jpm.obsticles.started = false
jpm.obsticles.timer = 0
jpm.obsticles.pick = 0

function jpm.obsticles.countDown(dt)
	if jpm.obsticles.startTimer <= 0 then
		jpm.obsticles.started = true
	else
		jpm.obsticles.startTimer = jpm.obsticles.startTimer - dt
	end
end

--For making new obsticles
function jpm.obsticles.newObject()
	local o = {}
	setmetatable(o, jpm.obsticles)

	o.x = 0
	o.y = -18
	o.size = 10
	o.act = false
	o.spd = 100
	o.accel = 200

	return o
end

--Generate the amount and size of the obsticles
function jpm.obsticles.generate()
	local count = 0
	while count <= 10 do
		count = count + 1
		table.insert(jpm.objects, jpm.obsticles.newObject())
	end
end

--Randomly pick an obsticle to fall every 0.25 of a second
function jpm.obsticles.randomise(dt)
	if jpm.obsticles.timer > 0.2 then
		jpm.obsticles.timer = 0
		jpm.obsticles.pick = math.random(1, 10)
		jpm.objects[jpm.obsticles.pick]:fall()
	else
		jpm.obsticles.timer = jpm.obsticles.timer + dt
	end
end

--Tell an obsticle to fall
function jpm.obsticles:fall()
	self.act = true
end

--Update the obsticle's y position (this makes it fall)
function jpm.obsticles:update(key, dt)
	self.x = (key-1)*10
	if self.act then
		if self.y <= 100 then
			self.y = self.y + self.spd*dt
			self.spd = self.spd + self.accel*dt
		else
			self.act = false
			self.y = -18
			self.spd = 100
		end
	end
end

--Draw the obsticle on the screen for you to see
function jpm.obsticles:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", jpm.screen.x(self.x), jpm.screen.y(self.y), jpm.screen.x(self.size), jpm.screen.x(self.size))
end