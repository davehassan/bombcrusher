require_relative 'board'
require 'byebug'

MAX_STACK_SIZE = 200
tracer = proc do |event|
  if event == 'call' && caller_locations.length > MAX_STACK_SIZE
    fail "Probable Stack Overflow"
  end
end
set_trace_func(tracer)

class Minesweeper

  attr_accessor :game_over, :board

  def initialize(dim, num_bombs)
    @board = Board.new(dim, num_bombs)
    @game_over = false
  end

  def handle_input
    puts "Please enter a command eg: 'r2,5' to reveal [2, 5]"
    input = gets.chomp
    char = input.split("").shift
    pos = input[1..-1].split(",").map { |x| x.to_i}

    if char == 'r'
      end_game if self.board[pos].bomb
      self.board.reveal(pos)
    else
      self.board[pos].flag
    end
  end

  def run
    until game_over
      system("clear")
      render
      handle_input
      puts "Congratulations!" if check_if_won
    end
  end

  def render
    display = []
    self.board.grid.each do |row|
      line = ""
      row.each do |tile|
        if tile.flagged
          line += "F "
        elsif !tile.revealed
          line += "* "
        elsif tile.bomb && tile.revealed
          line += "X "
        else
          c = tile.neighbor_bomb_count(self.board)
          c == 0 ? line += "_ " : line += "#{c} "
        end
      end
      puts line.chomp
    end

  end

  def end_game
    self.board.grid.each { |row| row.each { |tile| tile.reveal!} }
    render
    game_over = true
    puts "GAME OVER x_x"
  end

  def check_if_won
    game_over = self.board.grid.all? do |row|
      row.all? { |tile| tile.bomb ? !tile.revealed : tile.revealed }
    end
  end

end


if __FILE__ == $0
  dim = ARGV.shift.split("x").map { |x| x.to_i}
  num_bombs = ARGV.shift.to_i
  game = Minesweeper.new(dim, num_bombs)
  game.run
end
