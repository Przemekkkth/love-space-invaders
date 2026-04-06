Player = GameObject:extend()

function Player:new(area, x, y, opts)
    Player.super.new(self, area, x, y, opts)

    self.tex = PLAYER_TEXTURE
    self.scaleX = 1
    self.scaleY = 1
    self.centerX = self.tex:getWidth() * self.scaleX / 2
    self.centerY = self.tex:getHeight() * self.scaleY / 2
    self.x = SCREEN_WIDTH / 2
    self.y = SCREEN_HEIGHT - (PLAYER_TEXTURE:getHeight() * self.scaleY) - 10
    self.w = 2 * self.centerX
    self.h = 2 * self.centerY

    self.speed = PLAYER_SPEED
    self.stats = Stats()
    self.shootTimer = 0
    self.offset = PLAYER_TEXTURE:getWidth() / 2
    self.shoot_sfx = love.audio.newSource(AUDIO_PATH.PLAYER_LASER, 'static')
    self.hit_sfx = love.audio.newSource(AUDIO_PATH.PLAYER_HIT, 'static')
    self.bullets = {}
    self.area = area
end

function Player:update(dt)
    if input:down('move_left') then
        self.x = self.x - self.speed * dt
    elseif input:down('move_right') then
        self.x = self.x + self.speed * dt
    end

    if self.x - (self.offset * self.scaleX) <= 0 then
        self.x = (self.offset * self.scaleX)
    elseif self.x + (self.offset * self.scaleX) >= SCREEN_WIDTH then
        self.x = SCREEN_WIDTH - (self.offset * self.scaleX)
    end

    if self.shootTimer > 0 then
        self.shootTimer = self.shootTimer - dt
    end

    if input:down('space') then
        if self.shootTimer <= 0 then
            self:shoot()
            self.shootTimer = PLAYER_SHOOT_COOLDOWN_DURATION
        end
    end

    self:clear_bullets()
end

function Player:shoot()
    self.shoot_sfx:stop()
    self.shoot_sfx:play()
    table.insert(self.bullets, self.area:addGameObject('PlayerBullet', self.x - 4, self.y))
end

function Player:draw()
    love.graphics.draw(self.tex, self.x, self.y, 0, self.scaleX, self.scaleY, self.centerX, self.centerY)
    self.stats:draw()
end

function Player:hit()
    self.hit_sfx:stop()
    self.hit_sfx:play()
    self.stats.lives = self.stats.lives - 1
    if self.stats.lives > 0 then 
        self.alive = true 
    else
        self.alive = false
        self.area:addGameObject('DestroyedPlayerEffect', self.x, self.y)
    end
end

function Player:clear_bullets()
    for i = #self.bullets, 1, -1 do
        if not self.bullets[i].alive then
            table.remove(self.bullets, i)
        end
    end
end

function Player:add_score()
    self.stats.score = self.stats.score + 50
end