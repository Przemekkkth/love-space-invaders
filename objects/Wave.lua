Wave = GameObject:extend()

function Wave:new(area, x, y, opts)
    Wave.super.new(self, area, x, y, opts)

    self.enemies = {}
    self.direction = {x = 0, y = 0}
    self.moveCooldown = WAVE_MOVE_COOLDOWN_DURATION
    self.shootCooldown = WAVE_SHOOT_COOLDOWN_DURATION
    self.direction = {x = 1, y = 0}

    for x = 1, WAVE_COUNT.x do
        for y = 1, WAVE_COUNT.y do
            table.insert(self.enemies, self.area:addGameObject('Enemy', x - 1, y - 1))
        end
    end

    self.init_count = #self.enemies
end

function Wave:update(dt)
    if #self.enemies == 0 then
        go_to_room('Stage')
        return
    end

    for i = #self.enemies, 1, -1 do
        if self.enemies[i].alive then
            self.enemies[i]:update(dt)
        else
            table.remove(self.enemies, i)
        end
    end

    if self.shootCooldown > 0 then
        self.shootCooldown = self.shootCooldown - dt
    else
        self.shootCooldown = WAVE_SHOOT_COOLDOWN_DURATION + (self.init_count - #self.enemies) * 0.01
        self:event_enemy_shoot()
    end

    if self.moveCooldown > 0 then
        self.moveCooldown = self.moveCooldown - dt
    else
        self:handle_collisions_enemies_map()
        self.moveCooldown = WAVE_MOVE_COOLDOWN_DURATION - (self.init_count - #self.enemies) * 0.0135
        for i = #self.enemies, 1, -1 do
            self.enemies[i]:move(self.direction.x, self.direction.y)
        end
        self.direction.y = 0
    end

end

function Wave:draw()
    for i = #self.enemies, 1, -1 do
        self.enemies[i]:draw()
    end
end

function Wave:event_enemy_shoot()
    local random_index = math.random(1, #self.enemies)
    self.enemies[random_index]:shoot()
end

function Wave:handle_collisions_enemies_map()
    local leftmost_enemy = self.enemies[1]
    local rightmost_enemy = self.enemies[#self.enemies]

    local leftmost_position_x = leftmost_enemy.x + self.direction.x * 2 * leftmost_enemy.centerX
    local leftmost_position_y = leftmost_enemy.y + self.direction.y * 2 * leftmost_enemy.centerY
    local rightmost_position_x = rightmost_enemy.x + self.direction.x * 2 * rightmost_enemy.centerX
    local rightmost_position_y = rightmost_enemy.y + self.direction.y * 2 * rightmost_enemy.centerY

    if (self.direction.x < 0 and is_outside_window({x = leftmost_position_x, y = leftmost_position_y}))
        or (self.direction.x > 0 and is_outside_window({x = rightmost_position_x, y = rightmost_position_y})) then
            self.direction.x = self.direction.x * -1
            self.direction.y = 1
    end
end