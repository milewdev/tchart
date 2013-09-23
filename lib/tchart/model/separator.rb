module TChart
  
  #
  # The input data file specifies settings, data lines, and separators.
  # A separator renders as a horizontal grid line and serves to separate
  # the charted items into sections.  Responsible for building the grid
  # line element. 
  #
  class Separator
    
    #
    # This is part of the charted item interface.  Separators
    # have no date ranges so this array will always be empty.
    #
    attr_reader :date_ranges  
    
    def initialize
      @date_ranges = []
    end
    
    def build(layout, y) # => [ GridLine ]
      from = xy(0, y)
      to = xy(layout.x_axis_length, y)
      [ GridLine.new(from, to) ]
    end
    
  end
end
