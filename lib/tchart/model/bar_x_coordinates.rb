module TChart
  
  #
  # Represents the x coordinates of a bar on the chart, 
  # a bar being the representation of a date range.
  #
  # Bar coordinates consist of the mid-point of the bar
  # and the length of the bar, rather than the start and
  # end points of the bar.  This is what is expected by
  # the TikZ library.
  #
  class BarXCoordinates
    attr_reader :mid_point
    attr_reader :width
    
    def initialize(mid_point, width)
      @mid_point = mid_point
      @width = width
    end
  end
  
end
