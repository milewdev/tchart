module TChart
  
  #
  # Represents the x coordinates of a bar on the chart, 
  # a bar being the representation of a date range.
  #
  # Responsible for calculating the mid-point and width
  # of the bar as these are required by the TikZ library.
  #
  class BarXCoordinates
    
    def initialize(from, to)
      @from = from
      @to = to
    end
    
    def mid_point
      @from + (width / 2.0)
    end
    
    def width
      @to - @from
    end
    
  end
  
end
