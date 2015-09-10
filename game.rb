require './board'
require './player'
require './turn'
require 'pry'

class Game
  attr_accessor :board, :set_board, :computer, :user, :letter, :first_player, :take_turn, :map_to_board, :board_status, :has_won, :next_player

  def initialize
    @board = Board.new
  end

  def self.run
    game = Game.new
    user = Player.new("user")
    computer = Player.new("computer")

    if user.first_player == "y"
      active_player = user
      user.take_turn(game.board)
    else ## why is computer not taking its turn until a block move? ##
      active_player = computer
      computer.take_turn(game.board)
    end

    turn_counter = 0
    while game.board.has_won == false && turn_counter < 9
      active_player = active_player.computer == true ? user : computer
      active_player.take_turn(game.board)
      turn_counter += 1
    end

    # game over
    game.board.set_board
    if game.board.has_won == false
      puts "We tied. I am undefeatable yet again."
    elsif active_player.computer == true
      puts "YOU LOSE."
    else
      puts "Improbably, you have won. This is not ideal. Good day."
    end

  end
end

Game.run
