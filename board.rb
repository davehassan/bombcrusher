class Board

  attr_reader :dim
  attr_accessor :grid

  def initialize(dim = [9,9], num_bombs = 6)
    @dim = dim
    @grid = Array.new(dim[0]) {Array.new(dim[1])}
    self.fill
  end

  def in_bounds?(pos)
    (0...dim[0]).include?(pos[0]) && (0...dim[1]).include?(pos[1])
  end

  def [](pos)
    x,y = pos
    grid[x][y]
  end

  def []=(pos, value)
      self[pos] = value
  end

  def fill
    bombs = bomb_pos
    grid.each_with_index do |row, idx|
      row.each_index do |idy|
        pos = [idx, idy]
        bombs.include?(pos) ? val = :b : val = nil
        self[pos] = Tile.new(val, pos, self)
      end
    end
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
