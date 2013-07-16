module TChart
  
  #
  # Represents the x coordinates of a bar on the chart, 
  # a bar being the representation of a date range.
  #
  # SMELL: the name 'BarXCoordinates' is a mouthfull.
  # SMELL: is 'Bar' too specific?
  # SMELL: instead of  'x coordinates', we need something like 'x range'.
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
