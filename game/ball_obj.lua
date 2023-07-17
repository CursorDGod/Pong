require("game.settings")
function Ball()
  return {
    init = function(self)
      self.dx, self.dy, _ = love.window.getMode()
      self.x = (self.dx / 2) - ((DEFAULT_BLOCK_SIZE) / 2)
      self.y = (self.dy / 2) - ((DEFAULT_BLOCK_SIZE) / 2)
      self.xs = -DEFAULT_BALL_SPEED
      self.ys = math.random() * DEFAULT_BALL_SPEED
    end,

    max_sp = function(self, ply)
      if (self.ys + ((self.y - ply.y) * 0.3)) > (DEFAULT_PLY_SPEED + 1) then
        return DEFAULT_PLY_SPEED + 1
      else
        return self.ys + ((self.y - ply.y) * 0.3)
      end
    end,


    draw = function(self)
      love.graphics.rectangle("fill", self.x, self.y, DEFAULT_BLOCK_SIZE, DEFAULT_BLOCK_SIZE);
    end,



    update_pos = function(self)
      self.x = self.x + self.xs
      self.y = self.y + self.ys
    end,



    check_wall_col = function(self)
      if (self.y + 5) >= WINDOW_Y_SIZE - 1 then
        self.ys = self.ys * -1
      elseif (self.y - 5) <= 0 then
        self.ys = self.ys * -1
      end
    end,



    check_ply_col = function(self, players)
      for _, ply in pairs(players) do
        if ((ply.y - (ply.size / 2) <= self.y) and (ply.y + (ply.size / 2) >= self.y)) and ((ply.x - 1 * DEFAULT_BLOCK_SIZE <= self.x) and (ply.x + 1 * DEFAULT_BLOCK_SIZE >= self.x)) then
          self.xs = self.xs * -1
          self.ys = self:max_sp(ply)
        end
      end
    end,
    check_who_lose = function(self, players)
      if self.x < 0 then
        self:init()
        players[1]:count(1)
        self.xs = DEFAULT_BALL_SPEED
      elseif self.x >= WINDOW_X_SIZE then
        self:init()
        players[2]:count(1)
        self.xs = -DEFAULT_BALL_SPEED
      end
    end
  }
end
