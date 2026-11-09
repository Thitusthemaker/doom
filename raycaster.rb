require_relative 'map'
class Ray 
  def initialize(x,y,angle,map)
    @x = x
    @y = y
    @angle = angle
    @distance = 0
    @maxDistance = 1000
    @map = map
  end
  def cast
    while @map.collision?(@x,@y) == false && @distance <= @maxDistance
      @distance += 1
      @y += Math.sin(@angle)
      @x += Math.cos(@angle)     
    end
    return [@distance,@x, @y]
  end
end