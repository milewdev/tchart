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


module Kernel
  
  #
  # Syntactic sugar: xy(4, 2) is shorthand for Coordinate.new(4, 2)
  #
  def xy(x, y) # => Coordinate
    TChart::Coordinate.new(x, y)
  end

end
