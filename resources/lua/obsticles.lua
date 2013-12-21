jpm.obsticles = {}
jpm.obsticles.__index = jpm.obsticles

jpm.objects = {}

jpm.obsticles.startTimer = 5
jpm.obsticles.started = false
jpm.obsticles.timer = 0

function jpm.obsticles.countDown(dt)
	if jpm.obsticles.startTimer <= 0 then
		jpm.obsticles.started = true
		for k, v in pairs(jpm.players) do
			v.dead = false
		end
	else
		jpm.obsticles.startTimer = jpm.obsticles.startTimer - dt
	end
end

--For making new obsticles
function jpm.obsticles.newObject(x)
	local o = {}
	setmetatable(o, jpm.obsticles)

	o.x = x
	o.y = -18
	o.size = 10
	o.spd = 100
	o.accel = 100

	return o
end

function jpm.obsticles.reset()
	jpm.objects = {}
	
	jpm.obsticles.started = false
	jpm.obsticles.startTimer = 5
end

--Randomly pick an obsticle to fall every 0.25 of a second
function jpm.obsticles.randomise(dt)
	if jpm.obsticles.timer > 0.2 then
		jpm.obsticles.timer = 0
		table.insert(jpm.objects, jpm.obsticles.newObject(math.random(0, 9)*10))
	else
		jpm.obsticles.timer = jpm.obsticles.timer + dt
	end
end

--Update the obsticle's y position (this makes it fall)
function jpm.obsticles:update(key, dt)
	if self.y <= 100 then
		self.y = self.y + self.spd*dt
		self.spd = self.spd + self.accel*dt
	else
		table.remove(jpm.objects, key)
	end
end

--Draw the obsticle on the screen for you to see
function jpm.obsticles:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", jpm.screen.x(self.x), jpm.screen.y(self.y), jpm.screen.x(self.size), jpm.screen.x(self.size))
end