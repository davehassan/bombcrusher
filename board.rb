class Board

  def initialize(dim = [9,9], num_bombs = 6)
    @dim = dim
    @grid = Array.new(dim[0]) {Array.new(dim[1])}
    self.fill
  end


  def dimensions
  end

  def in_bounds?
  end

  def []
  end

  def fill

  end

  def bomb_pos
    bomb_pos = []
    while bomb_pos.count < num_bombs
      pos = [rand(dim[0]), rand(dim[1])]
      bomb_pos << pos unless bomb_pos.include?(pos)
    end
    bomb_pos
  end
  
end
