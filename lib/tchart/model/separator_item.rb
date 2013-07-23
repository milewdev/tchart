#
# SMELL: the attribute 'date_ranges'.  Use a message instead, such as #min_and_max_date.
# SMELL: #calc_layout and #render seem to split the responsibility of retrieving dimension information.
#
module TChart
  class SeparatorItem
    
    attr_reader :from
    attr_reader :to
    attr_reader :date_ranges
    
    def initialize
      @date_ranges = []
    end
    
    def calc_layout(chart, y)
      @from = Coordinate.new(0, y)
      @to = Coordinate.new(chart.x_axis_length, y)
    end
    
    def render(tex)
      tex.comment "horizontal separator line"
      tex.line from, to
    end
    
  end
end
