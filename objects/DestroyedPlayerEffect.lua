DestroyedPlayerEffect = GameObject:extend()

function DestroyedPlayerEffect:new(area, x, y, opts)
    DestroyedPlayerEffect.super.new(self, area, x, y, opts)
    self.timer = Timer()
    self.timer:after(3, function() 
        self.alive = false
        go_to_room('Stage')
    end)
    self.sfx = love.audio.newSource(AUDIO_PATH.PLAYER_DEAD, 'static')
    self.sfx:play()
end

function DestroyedPlayerEffect:update(dt)
    self.timer:update(dt)
end

function DestroyedPlayerEffect:draw()
    love.graphics.draw(DESTROYED_PLAYER_TEXTURE, self.x - DESTROYED_PLAYER_TEXTURE:getWidth() / 2, self.y - DESTROYED_PLAYER_TEXTURE:getHeight() / 2)
end