require './board'
require './player'
require 'pry'

class Turn
  attr_accessor :user_turn, :computer_turn, :winning_move, :board

  def self.take_turn(player, board)
    @board = board
    if player.user == true
      @board.set_board
      puts "\n\n Where would you like to play your letter?"
      position = gets.chomp
      if move_valid?(position)
        @board.mark_position(position, player.letter)
      else
        puts "\n NOPE. Try again. \n\n"
        self.take_turn(player, @board)
      end

    else
      computer_turn
    end
  end

  def self.move_valid?(position)
    !(/^[0-8]$/.match(position)).nil? && (/^[OX]$/.match(@board.flat[position.to_i])).nil?
  end

  def self.computer_turn
# Win, if possible
    if can_win?('O')
      ai_win
 # Block, if opponent can win      
    elsif can_win?('X')
      ai_block_opp
# Fork: Create an opportunity where you can win in two ways
    elsif about_to_get_fork?('O')
      take_empty_corner
# Block Opponent's Fork
    elsif about_to_get_fork?('X')
      make_opponent_block
# Center
    elsif @board.is_empty?(4)
      take_position("4")
# Opposite Corner: If the opponent is in the corner, play the opposite corner
    elsif has_corner_and_opposite_is_empty?('X')
      corner = @board.corner_position('X')
      take_opposite_corner(corner)
# Empty Corner: Play an empty corner
    elsif @board.corner_available?
      take_empty_corner
# Empty Side: Play an empty side
    elsif @board.is_empty?(1)
      take_position("1")
    elsif @board.is_empty?(5)
      take_position("5")
    elsif @board.is_empty?(7)
      take_position("7")
    elsif @board.is_empty?(3)
      take_position("3")
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


  class << self
    def can_win?(letter)
      !@board.winning_move(letter).empty?
    end

    def take_position(pos)
      @board.mark_position(pos, 'O')
    end

    def ai_win
      @board.claim_position(@board.winning_move('O').first, 'O')
    end

    def ai_block_opp
      @board.claim_position(@board.winning_move('X').first, 'O')
    end

    def has_corner?(letter)
      !@board.corner_position(letter).nil?
    end

    def take_empty_corner
      if @board.is_empty?(8)
        take_position("8")
      elsif @board.is_empty?(6)
        take_position("6")
      elsif @board.is_empty?(2)
        take_position("2")
      elsif @board.is_empty?(0)
        take_position("0")
      end
    end

    def take_opposite_corner(corner)
      take_position(@board.opposite_corner(corner))
    end

    def about_to_get_fork?(letter)
      corner = @board.corner_position(letter)
      opposite_value = @board.position(@board.opposite_corner(corner))
      !corner.nil? && opposite_value == letter
    end

    def has_corner_and_opposite_is_empty?(letter)
      corner = @board.corner_position(letter)
      !corner.nil? && @board.is_empty?(@board.opposite_corner(corner))
    end

    def make_opponent_block
      our_positions = @board.letter_locations('O')
      take_position(@board.empty_next_to(our_positions))
    end
  end

end

Turn.new
