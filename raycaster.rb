require_relative 'map'
class Ray 
  attr_reader :distance, :x, :y, :angle
  def initialize(x,y,angle,map, maxDist)
    @x = x
    @y = y
    @angle = angle
    @maxDistance = maxDist
    @distance = 0
    @map = map
    @jump = 3
  end
  def cast
    while @map.collision?(@x,@y) == false && @distance <= @maxDistance
      @distance += @jump
      @y += Math.sin(@angle)
      @x += Math.cos(@angle) 
      [@angle,@distance]    
    end
    if @distance < @maxDistance
      return [@angle, @distance]
    else
      return [@angle, @maxDistance+1]
    end
  end
end