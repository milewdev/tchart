#
# SMELL: the attribute 'date_ranges'.  Use a message instead, such as #min_and_max_date.
#
module TChart
  class SeparatorItem
    
    attr_reader :horizontal_gridline
    attr_reader :date_ranges
    
    def initialize
      @date_ranges = []
    end
    
    def build(layout, y)
      from = xy(0, y)
      to = xy(layout.x_axis_length, y)
      @horizontal_gridline = GridLine.build_hgridline(from, to)
    end
    
    def render(tex)
      tex.comment "horizontal separator line"
      horizontal_gridline.render(tex)
      tex.newline
    end
    
  end
end
