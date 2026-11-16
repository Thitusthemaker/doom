
class Map
  attr_reader :map, :blocksize
  def initialize()
    @blocksize = 50
    @map = [
      [0,0,0,1,0],
      [0,0,0,1,0],
      [0,0,1,1,0],
      [0,1,1,1,0],
      [1,1,0,1,0]
    ]
  end
  def collision?(x,y)
    begin
    blockX = (x/@blocksize).floor()
    blockY = (y/@blocksize).floor()
    
      if blockX < (@map[0].length) && blockX >= 0 && blockY < @map.length && blockY >= 0
        return @map[blockY][blockX] == 1 ? true : false
      end
    rescue StandardError => e
      p e
      p "#{x},#{y}"
      p "#{blockX},#{blockY}"
      p @map[0].length
      p blockX < (@map[0].length)
      p @blocksize
      exit!

    end
    false
  end
  
  def paint
    coords = []
    @map.each_index {|r| @map[r].each_index { |c| @map[r][c] == 1 ? coords << [r*@blocksize,c*@blocksize] : 0}}
    coords
  end
end
