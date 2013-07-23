#
# SMELL: the attribute 'date_ranges'.  Use a message instead, such as #min_and_max_date.
# SMELL: #calc_layout and #render seem to split the responsibility of retrieving dimension information.
#
module TChart
  class SeparatorItem
    
    attr_reader :y_coordinate
    attr_reader :length
    attr_reader :date_ranges
    
    def initialize
      @date_ranges = []
    end
    
    def calc_layout(chart, y_coordinate)
      @y_coordinate = y_coordinate
      @length = chart.x_axis_length
    end
    
    def render(tex)
      tex.comment "horizontal separator line"
      tex.line 0, y_coordinate, length, y_coordinate
    end
    
  end
end
