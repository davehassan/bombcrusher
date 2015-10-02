require_relative 'board'


class Tile

  attr_accessor :value, :pos, :flagged, :revealed, :neighbor_array
  attr_reader :board

  DELTAS = [[1,0],[-1,0],[0,1],[0,-1],[1,1],[1,-1],[-1,1],[-1,-1]]

  def initialize(value = nil, pos = [], board)
    @pos = pos
    @neighbor_array = neighbors(board)
    @flagged = false
    @revealed = false
    @value = neighbor_bomb_count unless value == :b
  end

  def reveal
    self.revealed = true unless flagged
  end

  def neighbors(board)

    x,y = self.pos

    DELTAS.each do |delta|
      a,b = delta
      try = [a + x, b + y]
      neighbor_array << board[try] if board.in_bounds?(try)
    end

    nil
  end

  def neighbor_bomb_count
    neighbor_array.count { |tile| tile.value == :b }
  end

  def inspect
    [self.pos, self.value]
  end

end
