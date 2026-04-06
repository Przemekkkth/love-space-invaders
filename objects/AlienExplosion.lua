AlienExplosion = GameObject:extend()

function AlienExplosion:new(area, x, y, opts)
    AlienExplosion.super.new(self, area, x, y, opts)

    self.timer = Timer()
    self.timer:after(0.4, function()
        self.alive = false 
    end)
end

function AlienExplosion:update(dt)
    self.timer:update(dt)
end


function AlienExplosion:draw()
    love.graphics.setColor(1, 1, 1, 0.75)
    love.graphics.draw(ALIEN_EXPLOSION_TEXTURE, ALIEN_QUADS[self.index], self.x - self.centerX, self.y - self.centerY)
    love.graphics.setColor(1, 1, 1, 1)
end
