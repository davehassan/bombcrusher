require_relative 'board'

class Tile

  attr_accessor :bomb, :pos, :flagged, :revealed, :neighbor_array
  attr_reader :board

  DELTAS = [[1,0],[-1,0],[0,1],[0,-1],[1,1],[1,-1],[-1,1],[-1,-1]]

  def initialize(bomb = false, pos = [])
    @pos = pos
    @flagged = false
    @revealed = false
    @bomb = bomb
  end

  def reveal
    self.revealed = true unless flagged
  end

  def reveal!
    self.revealed = true
  end

  def neighbors(board)

    neighbor_array = []

    x,y = self.pos

    DELTAS.each do |delta|
      a,b = delta
      try = [a + x, b + y]
      neighbor_array << board[try] if board.in_bounds?(try)
    end

  end

  def neighbor_bomb_count(board)
    neighbor_array = neighbors(board)
    neighbor_array.count { |tile| self.bomb }
  end

  def inspect
    [self.pos, self.bomb]
  end

  def flag
    self.flagged = !self.flagged
  end

end
