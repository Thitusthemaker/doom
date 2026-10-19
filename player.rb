class Player
  def initialize()
    @plInp = {}

    @tx = 0 # Translated X (objects position from origo)
    @ty = 0 # Translated Y (objects position from origo)

    @maxSpeed = 7
    @acceleration = 1.2  
    @retard = 0.3
    @dx = 0 # Speed X direction (from players direction)
    @dy = 0 # Speed Y direction
    @playerAngle = 0 # Player dir Facing (radians)
  end

  def getPlayerInput()
    @plInp["left"] = Gosu.button_down?(Gosu::KB_A)
    @plInp["right"] = Gosu.button_down?(Gosu::KB_D)
    @plInp["up"] = Gosu.button_down?(Gosu::KB_W)
    @plInp["down"] = Gosu.button_down?(Gosu::KB_S)

    @plInp["turn_l"] = Gosu.button_down?(Gosu::KB_LEFT)
    @plInp["turn_r"] = Gosu.button_down?(Gosu::KB_RIGHT)

    @plInp["shoot"] = Gosu.button_down?(Gosu::KB_SPACE)
  end
  def processPlayerInput()
    if @plInp["turn_l"]
      @playerAngle = (@playerAngle + (5 * (Math::PI/180))) % (Math::PI * 2)
    end
    if @plInp["turn_r"]
      @playerAngle = (@playerAngle - (5 * (Math::PI/180))) % (Math::PI * 2)
    end
    if @plInp["right"] || @plInp["left"]
      @dx += @plInp["right"] ? @acceleration : 0
      @dx -= @plInp["left"] ? @acceleration : 0

      @dx = @maxSpeed if @dx >= @maxSpeed 
      @dx = -@maxSpeed if @dx <= -@maxSpeed 
        
    else
      @dx = (-0.2 < @dx) && (@dx < 0.2) ? @retard * @dx : 0
    end

    if @plInp["up"] || @plInp["down"] 
      @dy += @plInp["up"] ? @acceleration : 0
      @dy -= @plInp["down"] ? @acceleration : 0

      @dy = @maxSpeed if @dy >= @maxSpeed 
      @dy = -@maxSpeed if @dy <= -@maxSpeed 
        
    else
      @dy = (-0.2 < @dy) && (@dy < 0.2) ? @retard * @dy : 0
    end
    
  end
  def movePlayer()
    r = (@dy**2 + @dx**2)**0.5

    v = @dy != 0 ? Math.tan(@dx/@dy) : 0 

    vx = r * Math.cos(v + @playerAngle)
    vy = r * Math.sin(v + @playerAngle)
    # theta = Math.acos(@dx/hypotenusa)
    # alpha = Math.asin(@dy/hypotenusa)
    # p theta
    # p alpha
    # p @movementRadius

    
    
    # vx = hypotenusa * Math.cos(theta - @playerAngle)
    # vy = hypotenusa * Math.sin(alpha - @playerAngle)
    p "#{vx} #{vy} : #{@dx} #{@dy}"
  end
end