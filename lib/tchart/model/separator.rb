#
# TODO: the attribute 'date_ranges'.  Use a message instead, such as #min_and_max_date.
#
module TChart
  class Separator
    
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
