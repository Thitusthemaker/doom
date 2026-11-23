require 'ractor'
require_relative 'raycaster'
require_relative 'map'
class RayCores
  def initialize(xCores)
    @xCores = xCores
    @cores = []
    start()
    # p @cores
  end
  def start()
    (0...@xCores).each do
      @cores << Ractor.new do
        loop do
          values = Ractor.receive
          break if values == :stop
          output = []
          workload = values[0]
          x = values[1]
          y = values[2]
          angle = values[3]
          step = values[4]
          map = values[5]
          maxDist = values[6]
          workload.each {|i| output << Ray.new(x,y,angle+(step*i),map,maxDist).cast}
          
          Ractor.yield output
        end
      end
    end
  end

  def work(x,y,angle,fov,xRays,map,maxDist) 
    sA = angle - fov/2.0
    eA = angle + fov/2.0
    step = (eA-sA)/xRays.to_f
    workload = []
    (0..@xCores).map.each {|core| workload << []}
    (0..xRays).map.each {|core| workload[core % @xCores] << core}
    @cores.each_index {|core| @cores[core].send([workload[core],x,y,angle,step,map,maxDist])}

  end  
  def grab()
    output = []
    @cores.each_index {|core| output << @cores[core].take()}
    output.flatten(1).sort()
  end
end

map = Map.new()
q = RayCores.new(3)
p q.work(0,0,0,90,360,map,2000)
# plx,ply,(pla + ((i * @fov)/@xRays) - (@fov/2)),@map, @rayMaxDist
# p q.get
# q.send(5)
# p q.get