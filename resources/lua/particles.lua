jpm.particles = {}

function jpm.particles.init()
	jpm.particles.image = love.graphics.newImage("resources/images/effects/particle.png");

	jpm.particles.fire = love.graphics.newParticleSystem(jpm.particles.image, 1000)

	jpm.particles.fire:setEmissionRate(100)
	jpm.particles.fire:setSpeed(300, 400)
	jpm.particles.fire:setGravity(100, 200)
	jpm.particles.fire:setSizes(2, 1)
	jpm.particles.fire:setColors(220, 105, 20, 255, 194, 30, 18, 0)
	jpm.particles.fire:setPosition(400, 300)
	jpm.particles.fire:setLifetime(0.1)
	jpm.particles.fire:setParticleLife(0.5)
	jpm.particles.fire:setDirection(1.57)
	jpm.particles.fire:setSpread(1)
	jpm.particles.fire:setSpin(150, 400)
	jpm.particles.fire:stop()

	jpm.particles.fire:setPosition(jpm.screen.x(jpm.players[1]:getX()+1), jpm.screen.y(jpm.players[1]:getY()+8))
end

function jpm.particles.update(dt)
	jpm.particles.fire:start()
	
	jpm.particles.fire:update(dt)
end

function jpm.particles.draw()
	love.graphics.draw(jpm.particles.fire, 0, 0)
end