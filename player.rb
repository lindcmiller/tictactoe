class Player
  attr_reader :computer, :user, :letter, :first_player, :grid, :turn

  def initialize(user_type)
    if user_type == "user"
      @computer = false
      @user = true
      @letter = "X"
    else
      @computer = true
      @user = false
      @letter = "O"
    end
  end

  def take_turn(grid)
    Turn.take_turn(self, grid)
  end

  def first_player
    puts "Would you like to make the first move? (y/n)"
    @first_player = gets.chomp
  end
end
