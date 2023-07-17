require("game.settings")
require("game.ball_obj")
require("game.player_obj")


function love.load()
  _G.bola = Ball()
  _G.ply1 = Player()
  _G.ply2 = Player()
  ply2:init("left", DEFAULT_BLOCK_SIZE * 10, true)
  bola:init()
  ply1:init("right", DEFAULT_BLOCK_SIZE * 10, false)
end

function love.update()
  bola:check_who_lose({ ply1, ply2 })
  bola:check_wall_col()
  bola:check_ply_col({ ply1, ply2 })
  ply1:move_person()
  bola.update_pos(bola)

  ply2:move_bot(bola)
end

function love.draw()
  love.graphics.clear()
  bola:draw()
  ply1:draw()
  ply2:draw()
end
