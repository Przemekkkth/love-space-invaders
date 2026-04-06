PLAYER_LIVES = 10
PLAYER_SPEED = 250
PLAYER_SHOOT_COOLDOWN_DURATION = 0.5
PLAYER_BULLET_RADIUS = 4
PLAYER_BULLET_SPEED = 500

WAVE_COUNT = {x = 11, y = 5}
WAVE_SPEEDUP_FACTOR = 0.95
WAVE_MOVE_COOLDOWN_DURATION = 0.8
WAVE_SHOOT_COOLDOWN_DURATION = 0.2

ENEMY_LIVES = 2
ENEMY_BULLET_RADIUS = 5
ENEMY_BULLET_SPEED = 200

BUNKER_COUNT = 4
BUNKER_SIZE = {x = 50, y = 50}
BUNKER_PART_COUNT = {x = 10, y = 10}
BUNKER_OFFSET_TOP_Y = 125
BUNKER_SPACING_X = 125

PLAYER_COLOR = {200/255, 200/255, 200/255}
PLAYER_BULLET_COLOR = {1, 0, 77/255}
PLAYER_SCORE_TEXT_COLOR = {1, 0, 77/255}
PLAYER_LIVES_TEXT_COLOR = {1, 0, 77/255}
ENEMY_FULL_COLOR = {1, 0, 0}
ENEMY_HALF_COLOR = {125/255, 125/255, 125/255}
BUNKER_COLOR = {82/255, 82/255, 82/255}
ENEMY_BULLET_COLOR = {1, 241/255, 232/255}

PLAYER_TEXTURE = love.graphics.newImage('assets/sprites/Spaceship.png')
DESTROYED_PLAYER_TEXTURE = love.graphics.newImage('assets/sprites/destroyed_spaceship.png')
ENEMY_1_TEXTURE = love.graphics.newImage('assets/sprites/Alien_1.png')
ENEMY_2_TEXTURE = love.graphics.newImage('assets/sprites/Alien_2.png')
ENEMY_3_TEXTURE = love.graphics.newImage('assets/sprites/Alien_3.png')
ENEMY_TEXTURES = {ENEMY_1_TEXTURE, ENEMY_2_TEXTURE, ENEMY_3_TEXTURE}
AUDIO_PATH = {
   ENEMY_DEAD = 'assets/sfx/enemy_explosion.ogg',
   PLAYER_LASER = 'assets/sfx/player_laser.ogg',
   PLAYER_HIT = 'assets/sfx/player_hit.ogg',
   PLAYER_DEAD = 'assets/sfx/player_dead.ogg'
}

ALIEN_EXPLOSION_TEXTURE = love.graphics.newImage('assets/sprites/explosion.png')
ALIEN1_EXPLOSION_QUAD = love.graphics.newQuad(0, 0, 30, 24, ALIEN_EXPLOSION_TEXTURE)
ALIEN2_EXPLOSION_QUAD = love.graphics.newQuad(30, 0, 30, 24, ALIEN_EXPLOSION_TEXTURE)
ALIEN3_EXPLOSION_QUAD = love.graphics.newQuad(60, 0, 30, 24, ALIEN_EXPLOSION_TEXTURE)
ALIEN_QUADS = {ALIEN1_EXPLOSION_QUAD, ALIEN2_EXPLOSION_QUAD, ALIEN3_EXPLOSION_QUAD}

FONT = love.graphics.newFont('assets/fonts/Montserrat.ttf', 20)

function is_outside_window(entity)
   return entity.x < 0 or entity.x > SCREEN_WIDTH or entity.y < 0 or entity.y > SCREEN_HEIGHT 
end

function clamp(v, min, max)
   if v < min then return min end
   if v > max then return max end
   return v
end

function circleRect(cx, cy, r, rx, ry, rw, rh)
   local closestX = clamp(cx, rx, rx + rw)
   local closestY = clamp(cy, ry, ry + rh)

   local dx = cx - closestX
   local dy = cy - closestY

   return dx*dx + dy*dy <= r*r
end

function AABB(ax, ay, aw, ah, bx, by, bw, bh)
   if ax < bx + bw and
      ax + aw > bx and
      ay < by + bh and
      ay + ah > by then
      return true
   end
   return false
end