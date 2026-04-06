Bunker = GameObject:extend()

function Bunker:new(area, x, y, opts)
    Bunker.super.new(self, area, x, y, opts)

    self.bunker_parts = {}
    self.area = area
    for i = 1, BUNKER_COUNT do
        self.bunker_parts[i] = {}
        self:set_bunker_part(i)
    end
end

function Bunker:update(dt)
    for i = 1, BUNKER_COUNT do
        for j = #self.bunker_parts[i], 1, -1 do
            if not self.bunker_parts[i][j].alive then
                table.remove(self.bunker_parts[i], j)
            end
        end
    end
end

function Bunker:draw()
end

function Bunker:set_bunker_part(i)
    local part_size = {x = BUNKER_SIZE.x / BUNKER_PART_COUNT.x, y = BUNKER_SIZE.y / BUNKER_PART_COUNT.y}
    local total_width = BUNKER_COUNT * BUNKER_SIZE.x + (BUNKER_COUNT - 1) * BUNKER_SPACING_X
    local start = {x = SCREEN_WIDTH / 2, y = SCREEN_HEIGHT - BUNKER_OFFSET_TOP_Y}
    local offset = {x = -total_width / 2 + (i-1) * (BUNKER_SIZE.x + BUNKER_SPACING_X), y = 0}

    for x = 0, BUNKER_PART_COUNT.x - 1 do
        for y = 0, BUNKER_PART_COUNT.y - 1 do    
            local left = {x = x * part_size.x, y = y * part_size.y}
            table.insert(self.bunker_parts[i], self.area:addGameObject('BunkerPart', start.x + offset.x + left.x, start.y + offset.y + left.y, {s = part_size.x}))
        end
    end
end