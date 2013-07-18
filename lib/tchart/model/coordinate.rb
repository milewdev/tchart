module TChart
  class Coordinate
    attr_reader :x
    attr_reader :y
    
    def initialize(x, y)
      @x = x
      @y = y
    end
  end
end
