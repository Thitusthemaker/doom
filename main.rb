require 'gosu'


class Game < Gosu::Window
  def initialize(gameWindow)
    super(gameWindow[0],gameWindow[1])
  end
end

q = Game.new([640,720])

q.show