BunkerPart = GameObject:extend()

function BunkerPart:new(area, x, y, opts)
    BunkerPart.super.new(self, area, x, y, opts)

    self.x = x
    self.y = y

    self.w = self.s
    self.h = self.s
    self.centerX = self.w / 2
    self.centerY = self.h / 2
    self.alive = true
end

function BunkerPart:update(dt)
    
end

function BunkerPart:draw()
    if not self.alive then
        return
    end
    love.graphics.setColor(BUNKER_COLOR)
    love.graphics.rectangle('fill', self.x, self.y, self.s, self.s, 0, 1, 1, self.centerX, self.centerY)
    love.graphics.setColor(1, 1, 1)
end