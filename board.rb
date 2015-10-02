class Board

  attr_reader :dim, :num_bombs
  attr_accessor :grid

  def initialize(dim = [9,9], num_bombs = 6)
    @dim = dim
    @grid = Array.new(dim[0]) {Array.new(dim[1])}
    @num_bombs = num_bombs
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
    bombs.each { |pos| self[pos] = Tile.new(:b, pos, self)}
    grid.each_with_index do |row, idx|
      row.each_index do |idy|
        pos = [idx, idy]
        self[pos] = Tile.new(nil, pos, self) unless bombs.include?(pos) 
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
