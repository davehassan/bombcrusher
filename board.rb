require_relative 'tile'
require 'byebug'

class Board

  attr_reader :dim, :num_bombs
  attr_accessor :grid

  def initialize(dim = [9,9], num_bombs = 10)
    # byebug
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
    x,y = pos
    grid[x][y] = value
  end

  def fill
    bombs = bomb_pos
    bombs.each { |pos| self[pos] = Tile.new(true, pos) }
    grid.each_with_index do |row, idx|
      row.each_index do |idy|
        pos = [idx, idy]
        self[pos] = Tile.new(false, pos) unless bombs.include?(pos)
      end
    end

    #grid.each { |row| row.each { |tile| tile.neighbors(self)}}
  end

  def bomb_pos
    positions = []
    while positions.count < num_bombs
      pos = [rand(dim[0]), rand(dim[1])]
      positions << pos unless positions.include?(pos)
    end
    positions
  end

  def reveal(pos)
    cur_tile = self[pos]
    cur_tile.reveal
    if cur_tile.neighbor_bomb_count(self) == 0
      cur_tile.neighbors(self).each do |xy|
        reveal(xy) unless self[xy].revealed
      end
    end
  end

  
end
