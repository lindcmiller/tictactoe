require './board'
require './player'
require 'pry'

class Turn
  attr_accessor :user_turn, :computer_turn, :winning_move, :board

  def self.take_turn(player, board)
    if player.user == true
      board.set_board
      puts "\n\n Where would you like to play your letter?"
      position = gets.chomp
      if move_valid?(position, board)
        board.mark_position(position, player.letter)
      else
        puts "\n NOPE. Try again. \n\n"
        self.take_turn(player, board)
      end

    else
      computer_turn(board)
    end
  end

  def self.move_valid?(position, board)
    !(/^[0-8]$/.match(position)).nil? && (/^[OX]$/.match(board.grid.flatten[position.to_i])).nil?
  end

  def self.computer_turn(board) # use case & when/then statements?
    if !board.winning_move('O').empty?
      board.claim_position(board.winning_move('O').first, 'O')
    elsif !board.winning_move('X').empty?
      board.claim_position(board.winning_move('X').first, 'O')

    elsif board.grid.flatten[4] == "X" && !["X", "O"].include?(board.grid.flatten[0])
      board.mark_position("0",'O')
    elsif board.grid.flatten[0] == "O" && !["X", "O"].include?(board.grid.flatten[8])
      board.mark_position("8",'O')

    # center space
    elsif !["X", "O"].include?(board.grid.flatten[4])
      board.mark_position("4", 'O')
    # elsif !["X", "O"].include?(board.grid.flatten[6])
    # board.mark_position("6", 'O')

      # corners
    elsif board.grid.flatten[0] == "X" && !["X", "O"].include?(board.grid.flatten[8])
      board.mark_position("8",'O')
    elsif board.grid.flatten[2] == "X" && !["X", "O"].include?(board.grid.flatten[6])
      board.mark_position("6",'O')
    elsif board.grid.flatten[6] == "X" && !["X", "O"].include?(board.grid.flatten[2])
      board.mark_position("2",'O')
    elsif board.grid.flatten[8] == "X" && !["X", "O"].include?(board.grid.flatten[0])
      board.mark_position("0",'O')

    # corner filled, take edge of untouching sides (opponent)
  elsif board.grid.flatten[2] == "X" && !["X", "O"].include?(board.grid.flatten[7])
      board.mark_position("7",'O')
    elsif board.grid.flatten[2] == "X" && !["X", "O"].include?(board.grid.flatten[3])
      board.mark_position("3",'O')

    elsif board.grid.flatten[6] == "X" && !["X", "O"].include?(board.grid.flatten[1])
      board.mark_position("1",'O')
    elsif board.grid.flatten[6] == "X" && !["X", "O"].include?(board.grid.flatten[5])
      board.mark_position("5",'O')

    elsif board.grid.flatten[8] == "X" && !["X", "O"].include?(board.grid.flatten[1])
      board.mark_position("1",'O')
    elsif board.grid.flatten[8] == "X" && !["X", "O"].include?(board.grid.flatten[3])
      board.mark_position("3",'O')

    elsif board.grid.flatten[0] == "X" && !["X", "O"].include?(board.grid.flatten[5])
      board.mark_position("5",'O')
    elsif board.grid.flatten[0] == "X" && !["X", "O"].include?(board.grid.flatten[7])
      board.mark_position("7",'O')
    else
      puts "NOPE."  
    end
  end

private

  def map_to_board
    mapping = {
      "0" => [0, 0],
      "1" => [1, 0],
      "2" => [2, 0],
      "3" => [0, 1],
      "4" => [1, 1],
      "5" => [2, 1],
      "6" => [0, 2],
      "7" => [1, 2],
      "8" => [2, 2]
    }
    mapping[turn]
  end

end

Turn.new
