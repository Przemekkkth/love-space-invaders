PlayerBullet = GameObject:extend()

function PlayerBullet:new(area, x, y, opts)
    PlayerBullet.super.new(self, area, x, y, opts)

    self.speed = PLAYER_BULLET_SPEED
    self.r = PLAYER_BULLET_RADIUS
    self.color = PLAYER_BULLET_COLOR
    self.alive = true
    self.w, self.h = 2 * self.r, 2 * self.r
    self.centerX = self.x + self.r
    self.centerY = self.y + self.r
end

function PlayerBullet:update(dt)
    if not self.alive then
        return
    end

    self.y = self.y - self.speed * dt
    self.centerY = self.y + self.r
    self.alive = not is_outside_window(self)
    if not self.alive then
        local default_color = {1, 163/255, 0}
        local color = {1, 119/255, 168/255}
        self.area:addGameObject('ProjectileDeathEffect', self.x, self.y, {w = 2*self.w, default_color = default_color, color = color})
    end
end


function PlayerBullet:draw()
    if not self.alive then
        return
    end
    love.graphics.setColor(self.color)
    love.graphics.circle('fill', self.centerX, self.centerY, self.r)
    love.graphics.setColor(1, 1, 1)
end
