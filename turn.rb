require './board'
require './player'

class Turn
  attr_accessor :user_turn, :computer_turn, :winning_move

  def self.take_turn(player, board)
    if player.user == true
      board.set_board
      puts "\n\nWhere would you like to play your letter?" ## why 2 new lines? ##
      position = gets.chomp
      board.mark_position(position, player.letter)
    else
      computer_turn(board)
    end
  end

  def board_status
    turn_counter = 0 # purpose: so if there are no win and no places to move, tie message is delivered & game stops
    unless has_won || turn_counter == 9
      take_turn
      turn_counter += 1
    end

  end

  def self.computer_turn(board) # use case & when/then statements?
    if !board.winning_move('O').empty?
      board.claim_position(board.winning_move('O').first, 'O')
    elsif !board.winning_move('X').empty?
      board.claim_position(board.winning_move('X').first, 'O')
    elsif
      if !["X", "O"].include?(board.grid.flatten[4])
        board.mark_position("4", 'O')
      end
    elsif
      if board.grid.flatten[8] == "X" && !["X", "O"].include?(board.grid.flatten[0])
        board.mark_position("0",'O')
      elsif board.grid.flatten[6] == "X" && !["X", "O"].include?(board.grid.flatten[2])
        board.mark_position("2",'O')
      elsif board.grid.flatten[0] == "X" && !["X", "O"].include?(board.grid.flatten[8])
        board.mark_position("8",'O')
      elsif board.grid.flatten[2] == "X" && !["X", "O"].include?(board.grid.flatten[2])
        board.mark_position("6",'O')
      end
    elsif
      if !["X", "O"].include?(board.grid.flatten[8])
        board.mark_position("8", 'O')
      elsif !["X", "O"].include?(board.grid.flatten[6])
        board.mark_position("6", 'O')
      elsif !["X", "O"].include?(board.grid.flatten[2])
        board.mark_position("2", 'O')
      else !["X", "O"].include?(board.grid.flatten[0])
        board.mark_position("0", 'O')
      end
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
    mapping[turn] #where is "turn" created?
  end

  def block_move
    if 1 == 1
      i.delete_at(i)
      i << computer.letter
    end
  end

  def block_fork
    if 0 == 0 || 2 == 2 || 6 == 6 || 8 == 8
      i.delete_at(i)
      i << computer.letter
    end
  end
end

Turn.new
