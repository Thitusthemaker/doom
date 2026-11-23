require 'gosu'
require 'gosu_more_drawables'
# require_relative 'gameSettings'   
require_relative 'player'   
require_relative 'map'
require_relative 'raycaster'
# require_relative 'threading'
require 'thread'
require_relative 'Cores'


class Game < Gosu::Window
  def initialize(width,height)
    super(width,height)
    @height = height
    @width = width
    @player = Player.new
    @map = Map.new
    @workers = RayCores.new(8)
    @xRays = 360
    @fov = Math::PI/2
    @casts = []
    @rayMaxDist = 2000
    @DEBUG = 0
  end
  def raycast()
    plx = @player.tx
    ply = @player.ty
    pla = @player.playerAngle

    @workers.work(plx,ply,pla,@fov,@xRays,@map,@maxDist)

  end

  def update
    @player.getPlayerInput()
    @player.processPlayerInput()
    @player.movePlayer()
    raycast()
    self.caption = "#{Gosu.fps}"
  end
  
  def draw
    render(@workers.grab)

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

  def render(rays)
    # rays = []
    # points.each {|point| distances << point[0]}    
    
    dx = (@width /@xRays.to_f).ceil
  
    x = 0
    ray = 0
    while ray < @xRays
      r = rays[ray][1]
      # id = rays[ray].id()
      # x = dx*id
      # a = rays[ray].angle()
      # p a
      # r = distances[ray]
      # z = r* Math.cos(a)

      if (r != 0) && (r <= 2000)
        y1 = (@height/2) - 99999/r
        y2 = (@height/2) - -99999/r
        dy = y2-y1
        fade = (500/r.to_f).abs 
        fade = fade >= 1 ? 1 : fade
        
        draw_line(x,y1,Gosu::Color::BLACK,x,y2,Gosu::Color::BLACK,1)
        draw_rect(x,y1,dx,dy,Gosu::Color.rgb(100*fade, 80*fade, 80*fade),1)
      end
      ray += 1
      x += dx
    end
  end
end

q = Game.new(1920,1080).show