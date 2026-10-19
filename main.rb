require 'gosu'
# require_relative 'gameSettings'   
require_relative 'player'   


class Game < Gosu::Window
  def initialize(height,width)
    super(height,width)

    @player = Player.new
  end
  def update
    @player.getPlayerInput()
    @player.processPlayerInput()
    @player.movePlayer()

  end
  def draw
  end

  
  
end

q = Game.new(1920,1080).show