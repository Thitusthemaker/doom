require 'gosu'
require 'gosu_more_drawables'
# require_relative 'gameSettings'   
require_relative 'player'   
require_relative 'map'
require_relative 'raycaster'

class Game < Gosu::Window
  def initialize(height,width)
    super(height,width)
    @height = height
    @width = width
    @player = Player.new
    @map = Map.new
    @rays = 180
    @fov = Math::PI/2
  end
  def update
    @player.getPlayerInput()
    @player.processPlayerInput()
    @player.movePlayer()

  end
  def draw

    plx = @player.tx
    ply = @player.ty
    pla = @player.playerAngle
    blocks = @map.paint

    blocks.each { |block| Gosu.draw_rect(block[1],block[0], @map.blocksize, @map.blocksize, Gosu::Color::BLUE, 0)}
    Gosu.draw_circle(plx, ply, 15, 36, Gosu::Color::RED, 0)
    distances = []

    for i in 0...@rays
      ray =  Ray.new(plx,ply,(pla + ((i * @fov)/@rays) - (@fov/2)),@map)
      distances << ray.cast
    end
    
    distances.each {|dist| draw_line(plx,ply, Gosu::Color::GREEN, dist[1],dist[2], Gosu::Color::GREEN,0)}

    # makeit3d(distances)
    # draw_line(plx,ply, Gosu::Color::GREEN, cords[1],cords[2], Gosu::Color::GREEN,0)
  end
 
    
  

  
  
end

q = Game.new(1920,1080).show