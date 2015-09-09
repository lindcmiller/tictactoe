require './board'
require './player'
require './turn'
require 'pry'

class Game
  attr_accessor :grid, :set_board, :computer, :user, :letter, :first_player, :take_turn, :map_to_board, :board_status, :has_won, :next_player

  def initialize
    @grid = Board.new
  end

  def self.run
    game = Game.new
    user = Player.new("user")
    computer = Player.new("computer")

    if user.first_player == "y"
      active_player = user
      user.take_turn(game.grid)

    else ## why is computer not taking its turn until a block move? ##
      active_player = computer
      computer.take_turn(game.grid)
    end

    while game.grid.has_won == false
      active_player = active_player.computer == true ? user : computer
      active_player.take_turn(game.grid)
    end

    # game over
    if active_player.computer == true
      puts "YOU LOSE."
    elsif grid.flatten.uniq.size < 2 # for tie
      puts "Welp, we have no winners here."
    else
      puts "Improbably, you have won. This is not ideal. Good day."
    end

  end
end

Game.run
