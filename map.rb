
class Map
  attr_reader :map, :blocksize
  def initialize()
    @blocksize = 100
    @map = [
      [0,0,0,1,0],
      [0,0,0,1,0],
      [0,0,1,1,0],
      [0,1,1,1,0],
      [1,1,0,1,0]
    ]
  end
  def collision?(x,y)
    blockX = (x/@blocksize).floor()
    blockY = (y/@blocksize).floor()
    # p "#{blockX} , #{blockY}"
    if blockX < @map[0].length && blockY < @map.length
      return @map[blockY][blockX] == 1 ? true : false
    end
      false
  end
  
  def paint
    coords = []
    @map.each_index {|r| @map[r].each_index { |c| @map[r][c] == 1 ? coords << [r*@blocksize,c*@blocksize] : 0}}
    coords
  end
end
