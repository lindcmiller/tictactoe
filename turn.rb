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
      board.claim_position(board.winning_move('O').first, 'O')d
      board.claim_position(board.winning_move('X').first, 'X')

    elsif if !board.winning_move('O').empty? #corner
      board.claim_position(board.winning_move(6).first, 'O')
    elsif !board.winning_move('X').empty?
      board.claim_position(board.winning_move(6).first, 'X')

    elsif if !board.winning_move('O').empty? #corner
      board.claim_position(board.winning_move(8).first, 'O')
    elsif !board.winning_move('X').empty?
      board.claim_position(board.winning_move(8).first, 'X')

    elsif if !board.winning_move('O').empty? #corner
      board.claim_position(board.winning_move(2).first, 'O')
    elsif !board.winning_move('X').empty?
      board.claim_position(board.winning_move(2).first, 'X')

    elsif if !board.winning_move('O').empty? #corner
      board.claim_position(board.winning_move(0).first, 'O')
    elsif !board.winning_move('X').empty?
      board.claim_position(board.winning_move(0).first, 'X')

    elsif !board.winning_move('O').empty? #center
      board.claim_position(board(4), 'O')
    else !board.winning_move('X').empty?
        board.claim_position(board(4), 'X')
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
  end
end

# Turn.new
