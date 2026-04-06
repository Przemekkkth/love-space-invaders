Area = Object:extend()

function Area:new(room)
    self.room = room
    self.game_objects = {}
    self.player = self:addGameObject('Player')
    self.bunker = self:addGameObject('Bunker')
    self.wave = self:addGameObject('Wave') 
end

function Area:update(dt)
    for i = #self.game_objects, 1, -1 do
        local game_object = self.game_objects[i]
        game_object:update(dt)
        if not game_object.alive then 
            table.remove(self.game_objects, i) 
        end
    end

    self:handle_collisions_enemies_bunker()
    self:handle_collisions_player_bullets()
    self:handle_collisions_enemy_bullets()
end

function Area:draw()
    for _, game_object in ipairs(self.game_objects) do game_object:draw() end
end

function Area:addGameObject(game_object_type, x, y, opts)
    local opts = opts or {}
    local game_object = _G[game_object_type](self, x or 0, y or 0, opts)
    table.insert(self.game_objects, game_object)
    return game_object
end

function Area:handle_collisions_enemies_bunker()
    local count_bunker_parts = #self.bunker.bunker_parts
    if count_bunker_parts == 0 then
        return
    end

    local last_index = #self.bunker.bunker_parts[count_bunker_parts]
    local bunker_pos_y = self.bunker.bunker_parts[count_bunker_parts][last_index].y

    local collision = false

    for _, enemy in ipairs(self.wave.enemies) do
        if enemy.y > bunker_pos_y - enemy.centerY * 2 * 2 then
            collision = true
        end
    end

    if collision then
        self.player.stats.lives = 0
    end
end

function Area:handle_collisions_player_bullets()
    for _, bullet in ipairs(self.player.bullets) do
        local bullet_left = bullet.x - bullet.r / 2
        local bullet_top = bullet.y - bullet.r / 2

        for i = 1, BUNKER_COUNT do
            local bunker_parts = self.bunker.bunker_parts[i]
            for j = #bunker_parts, 1, -1 do
                if AABB(bullet_left, bullet_top, bullet.w, bullet.h, bunker_parts[j].x, bunker_parts[j].y, bunker_parts[j].w, bunker_parts[j].h)
                    and bullet.alive
                then
                    bullet.alive = false
                    bunker_parts[j].alive = false
                    break
                end
            end
        end

        for _, enemy in ipairs(self.wave.enemies) do
            if AABB(bullet_left, bullet_top, bullet.w, bullet.h, enemy.x - enemy.w / 2, enemy.y - enemy.h / 2, enemy.w, enemy.h)
                and bullet.alive
            then
                bullet.alive = false
                self.player:add_score()
                enemy:hit()
                return
            end
        end
    end
end

function Area:handle_collisions_enemy_bullets()
    for _, enemy in ipairs(self.wave.enemies) do
        for _, bullet in ipairs(enemy.bullets) do
            local bullet_left = bullet.x - bullet.r / 2
            local bullet_top = bullet.y - bullet.r / 2
    
            for i = 1, BUNKER_COUNT do
                local bunker_parts = self.bunker.bunker_parts[i]
                for j = 1, #bunker_parts, 1 do
                    if AABB(bullet_left, bullet_top, bullet.w, bullet.h, bunker_parts[j].x, bunker_parts[j].y, bunker_parts[j].w, bunker_parts[j].h)
                        and bullet.alive
                    then
                        bullet.alive = false
                        bunker_parts[j].alive = false
                        break
                    end
                end
            end
    
            if AABB(bullet_left, bullet_top, bullet.w, bullet.h, self.player.x - self.player.w / 2, self.player.y - self.player.h / 2, self.player.w, self.player.h)
             and bullet.alive
            then
                bullet.alive = false
                self.player:hit()
            end
        end
    end
end