Enemy = GameObject:extend()

function Enemy:new(area, x, y, opts)
    Enemy.super.new(self, area, x, y, opts)

    self.lives = ENEMY_LIVES
    self.index = math.floor((y + 1) / 2 + 1)
    self.tex = ENEMY_TEXTURES[self.index]
    self.scaleX = 1
    self.scaleY = 1
    self.centerX = self.tex:getWidth() * self.scaleX / 2
    self.centerY = self.tex:getHeight() * self.scaleY / 2
    self.x = (2*self.centerX) + (4*self.centerX) * x
    self.y = (2*self.centerY) + (4*self.centerY) * y
    self.w = 2 * self.centerX
    self.h = 2 * self.centerY
    self.bullets = {}
    self.alive = true
    self.dead_sfx = love.audio.newSource(AUDIO_PATH.ENEMY_DEAD, 'static')
end

function Enemy:update(dt)
    for i = #self.bullets, 1, -1 do
        if not self.bullets[i].alive then
            table.remove(self.bullets, i)
        else
            self.bullets[i]:update(dt)
        end
    end
end

function Enemy:draw()
    love.graphics.setColor(1, 1, 1, self.lives / ENEMY_LIVES)
    love.graphics.draw(self.tex, self.x, self.y, 0, self.scaleX, self.scaleY, self.centerX, self.centerY)
    for _, bullet in ipairs(self.bullets) do
        bullet:draw()
    end
    love.graphics.setColor(1, 1, 1, 1)
end

function Enemy:shoot()
    local bullet = Bullet(self.x, self.y, 'down')
    table.insert(self.bullets, self.area:addGameObject('EnemyBullet', self.x - 4, self.y))
end

function Enemy:move(unitX, unitY)
    self.x = self.x + unitX * self.centerX
    self.y = self.y + unitY * self.centerY
end

function Enemy:hit()
    self.lives = self.lives - 1
    if self.lives > 0 then 
        self.alive = true 
    else 
        self.area:addGameObject('AlienExplosion', self.x, self.y, {index = self.index, centerX = self.centerX, centerY = self.centerY})
        self.alive = false 
        self.dead_sfx:play() 
    end
end