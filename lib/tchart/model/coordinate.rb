module TChart
  
  #
  # An (x,y) location on the chart.  x and y can be
  # in any units, e.g. millimeters, pixels, etc.
  #
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
  # Shorthand for TChart::Coordinate.new(x, t).
  #
  def xy(x, y) # => Coordinate
    TChart::Coordinate.new(x, y)
  end
end
