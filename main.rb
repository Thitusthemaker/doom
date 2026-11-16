require 'gosu'
require 'gosu_more_drawables'
# require_relative 'gameSettings'   
require_relative 'player'   
require_relative 'map'
require_relative 'raycaster'

class Game < Gosu::Window
  def initialize(width,height)
    super(width,height)
    @height = height
    @width = width
    @player = Player.new
    @map = Map.new
    @rays = 360
    @fov = Math::PI/2
    @casts = []
    @rayMaxDist = 2000
    @DEBUG = 0
  end
  def raycast()
    plx = @player.tx
    ply = @player.ty
    pla = @player.playerAngle
    
    @casts = []
    for i in 0...@rays
      ray =  Ray.new(plx,ply,(pla + ((i * @fov)/@rays) - (@fov/2)),@map, @rayMaxDist)
      @casts << ray.cast
    end
  end
  def update
    @player.getPlayerInput()
    @player.processPlayerInput()
    @player.movePlayer()
    raycast()

  end
  
  def draw
    render(@casts)

    if @DEBUG == 1
      plx = @player.tx
      ply = @player.ty
      pla = @player.playerAngle
      blocks = @map.paint

      blocks.each { |block| Gosu.draw_rect(block[1],block[0], @map.blocksize, @map.blocksize, Gosu::Color::BLUE, 3)}
      @casts.each {|dist| draw_line(plx,ply, Gosu::Color::GREEN, dist[1],dist[2], Gosu::Color::GREEN,3)}
      
      Gosu.draw_circle(plx, ply, 15, 36, Gosu::Color::RED, 3)
    end
  end

  def render(points)
    distances = []
    points.each {|point| distances << point[0]}    
    
    dx = (@width /@rays.to_f).ceil
    
    ray = 0
    x = 0

    
    while x < @width
      distance = distances[ray]
      if (distance != 0) && (distance <= 2000)
        y1 = (@height/2) - 99999/distance
        y2 = (@height/2) - -99999/distance
        dy = y2-y1
        fade = (500/distance.to_f) 
        fade = fade >= 1 ? 1 : fade
        
        draw_line(x,y1,Gosu::Color::WHITE,x,y2,Gosu::Color::BLACK,1)
        draw_rect(x,y1,dx,dy,Gosu::Color.rgb(100*fade, 80*fade, 80*fade),1)
      end
      ray += 1
      x += dx
    end
  end
  
end

q = Game.new(1920,1080).show