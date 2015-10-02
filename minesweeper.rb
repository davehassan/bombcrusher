require_relative 'board'

class Minesweeper

  attr_accessor :game_over

  def initialize()
    @board = Board.new(dim, num_bombs)
    @game_over = false
  end

  def handle_input
    puts "Please enter a command eg: 'r2,5' to reveal [2, 5]"
    input = gets.chomp
    char = input.shift
    pos = input.split(",").map { |x| x.to_i}

    if char == 'r'
      end_game if board[pos].bomb
      board.reveal(pos)
    else
      board[pos].flag
    end
  end

  def run
    until game_over?
      render
      handle_input
      check_game_state
    end
  end

  def render
    display = []
    board.each do |row|
      line = []
      row.each do |tile|
        if tile.flagged
          line << "F"
        elsif !tile.revealed
          line << "*"
        else
          c = tile.neighbor_bomb_count(board)
          c == 0 ? line << "_" : line << c.to_s
        end
      end
      puts line
    end

  end

  def end_game
    board.each { |row| row.each { |tile| tile.reveal!} }
    render
    game_over = true
    puts "GAME OVER x_x"
  end

  def check_game_state
  end

end




if __FILE__ == $0
  #things
end
