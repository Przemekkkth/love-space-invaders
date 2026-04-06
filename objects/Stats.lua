Stats = Object:extend()

function Stats:new()
    self.score = 0
    self.lives = PLAYER_LIVES
end

function Stats:update(dt)
    
end

function Stats:draw_score()
    love.graphics.setFont(FONT)
    love.graphics.setColor(PLAYER_SCORE_TEXT_COLOR)
    love.graphics.print('Score: '..self.score, 5, 5)
    love.graphics.setColor(PLAYER_LIVES_TEXT_COLOR)
    love.graphics.print('Lives: '..self.lives, 5, 35)
    love.graphics.setColor(1, 1, 1)
end

function Stats:draw()
    self:draw_score()
end