Bullet = Object:extend()

function Bullet:new(x, y, direction)
    self.x = x
    self.y = y
    self.alive = true
    if direction == 'up' then
        self.direction = -1
        self.speed = PLAYER_BULLET_SPEED
        self.r = PLAYER_BULLET_RADIUS
        self.color = PLAYER_BULLET_COLOR
    elseif direction == 'down' then
        self.direction = 1
        self.speed = ENEMY_BULLET_SPEED
        self.r = ENEMY_BULLET_RADIUS
        self.color = ENEMY_BULLET_COLOR
    end

    self.w, self.h = 2 * self.r, 2 * self.r
end

function Bullet:update(dt)
    if not self.alive then
        return
    end
    self.y = self.y + self.speed * self.direction * dt
    self:is_outside_screen()
end

function Bullet:draw()
    if not self.alive then return end
    love.graphics.setColor(self.color)
    love.graphics.circle('fill', self.x, self.y, self.r)
    love.graphics.setColor(1, 1, 1)
end

function Bullet:is_outside_screen()
    if self.y < 2*self.r then
        self.alive = false
    elseif self.y > SCREEN_HEIGHT + 2 * self.r then
        self.alive = false
    end
end