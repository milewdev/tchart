module TChart
  class BarXCoordinates
    attr_reader :mid_point
    attr_reader :width
    
    def initialize(mid_point, width)
      @mid_point = mid_point
      @width = width
    end
  end
end
