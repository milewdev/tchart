module TChart
  
  #
  # Represents the x coordinates of a bar on the chart, 
  # a bar being the representation of a date range.
  #
  class BarXCoordinates
    
    attr_reader :from
    attr_reader :to
    
    def initialize(from, to)
      @from = from
      @to = to
    end
    
  end
  
end
