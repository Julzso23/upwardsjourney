jpm.particles = {}

function jpm.particles.init()
	jpm.particles.image = love.graphics.newImage("resources/images/effects/particle.png");

	jpm.particles.fire1 = love.graphics.newParticleSystem(jpm.particles.image, 1000)
	jpm.particles.fire2 = love.graphics.newParticleSystem(jpm.particles.image, 1000)

	jpm.particles.fire1:setEmissionRate(75)
	jpm.particles.fire1:setSpeed(300, 400)
	jpm.particles.fire1:setGravity(100, 200)
	jpm.particles.fire1:setSizes(jpm.screen.x(0.15625), jpm.screen.x(0.078125))
	jpm.particles.fire1:setColors(220, 105, 20, 255, 104, 30, 18, 100, 25, 25, 25, 0)
	jpm.particles.fire1:setPosition(400, 300)
	jpm.particles.fire1:setLifetime(0.1)
	jpm.particles.fire1:setParticleLife(0.5)
	jpm.particles.fire1:setDirection(1.57)
	jpm.particles.fire1:setSpread(1)
	jpm.particles.fire1:setSpin(150, 400)
	jpm.particles.fire1:stop()

	jpm.particles.fire2:setEmissionRate(75)
	jpm.particles.fire2:setSpeed(300, 400)
	jpm.particles.fire2:setGravity(100, 200)
	jpm.particles.fire2:setSizes(jpm.screen.x(0.15625), jpm.screen.x(0.078125))
	jpm.particles.fire2:setColors(220, 105, 20, 255, 104, 30, 18, 100, 25, 25, 25, 0)
	jpm.particles.fire2:setPosition(400, 300)
	jpm.particles.fire2:setLifetime(0.1)
	jpm.particles.fire2:setParticleLife(0.5)
	jpm.particles.fire2:setDirection(1.57)
	jpm.particles.fire2:setSpread(1)
	jpm.particles.fire2:setSpin(150, 400)
	jpm.particles.fire2:stop()

	jpm.particles.fire1:setPosition(jpm.screen.x(jpm.players[1]:getX()-0.5), jpm.screen.y(jpm.players[1]:getY()+9))
	jpm.particles.fire2:setPosition(jpm.screen.x(jpm.players[1]:getX()+2), jpm.screen.y(jpm.players[1]:getY()+9))
end

function jpm.particles.update(dt)
	jpm.particles.fire1:start()
	jpm.particles.fire1:update(dt)
	jpm.particles.fire2:start()
	jpm.particles.fire2:update(dt)
end

function jpm.particles.draw()
	love.graphics.draw(jpm.particles.fire1, 0, 0)
	love.graphics.draw(jpm.particles.fire2, 0, 0)
end