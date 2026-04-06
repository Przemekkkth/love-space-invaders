ProjectileDeathEffect = GameObject:extend()

function ProjectileDeathEffect:new(area, x, y, opts)
    ProjectileDeathEffect.super.new(self, area, x, y, opts)
    self.timer = Timer()
    self.first = true
    self.timer:after(0.1, function()
        self.first = false
        self.second = true
        self.timer:after(0.15, function()
            self.second = false
            self.alive = false
        end)
    end)
end

function ProjectileDeathEffect:update(dt)
    self.timer:update(dt)
end

function ProjectileDeathEffect:draw()
    if self.first then love.graphics.setColor(self.default_color)
    elseif self.second then love.graphics.setColor(self.color) end
    local y = nil
    if self.y > SCREEN_HEIGHT / 2 then
        y = SCREEN_HEIGHT - self.w/4
    else
        y = -3*self.w/4
    end
    love.graphics.rectangle('fill', self.x - self.w/2, y, self.w, self.w)
    love.graphics.setColor(1,1,1,1)
end