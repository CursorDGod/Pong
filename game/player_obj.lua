require("game.settings")
function Player()
  return {
    init = function(self, side, size, bot)
      if side == "left" then
        self.x = 1
      elseif side == "right" then
        self.x = WINDOW_X_SIZE - DEFAULT_BLOCK_SIZE
      end
      self.y = (WINDOW_Y_SIZE / 2)
      self.side = side
      self.size = size
      self.bot = bot
      self.points = 0
      self.t_pos_y = 0
      if self.side == "left" then
        self.t_pos_x = WINDOW_X_SIZE / 4
      elseif self.side == "right" then
        self.t_pos_x = WINDOW_X_SIZE - WINDOW_X_SIZE / 4
      end
    end,



    draw = function(self)
      love.graphics.rectangle("line", self.x, self.y - self.size / 2, DEFAULT_BLOCK_SIZE, self.size)
      love.graphics.print(tostring(self.points), self.t_pos_x, self.t_pos_y)
    end,



    move_person = function(self)
      if not self.bot then
        if #love.touch.getTouches() > 0 then
          _, self.touch_y = love.touch.getPosition(love.touch.getTouches()[1])
        end
        if love.keyboard.isDown("up") or (self.touch_y or WINDOW_Y_SIZE / 2) < WINDOW_Y_SIZE / 2 then
          self.y = self.y - DEFAULT_PLY_SPEED
        elseif love.keyboard.isDown("down") or (self.touch_y or WINDOW_Y_SIZE / 2) > WINDOW_Y_SIZE / 2 then
          self.y = self.y + DEFAULT_PLY_SPEED
        end
      end
    end,



    move_bot = function(self, ball)
      if self.bot then
        if ball.y >= self.y then
          self.y = self.y + DEFAULT_PLY_SPEED
        elseif ball.y < self.y then
          self.y = self.y - DEFAULT_PLY_SPEED
        end
      end
    end,
    count = function(self, v)
      self.points = self.points + v
    end
  }
end
