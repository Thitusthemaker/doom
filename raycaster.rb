require_relative 'map'
class Ray 
  attr_reader :maxDistance
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
    end
    if @distance < @maxDistance
      return [@distance,@x, @y]
    else
      return [@maxDistance+1,0,0]
    end
  end
end