module TChart
  class Separator
    
    # This is part of the charted item interface.  Separators
    # have no date ranges so this array will always be empty.
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
