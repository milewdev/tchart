module TChart
  class SeparatorItem
    
    attr_reader :y_coordinate
    attr_reader :date_ranges        # TODO: smell
    
    def initialize
      @date_ranges = []
    end
    
    def calc_layout(chart, y_coordinate)
      @y_coordinate = y_coordinate
    end
    
    def render(chart)
      output = StringIO.new
      tex = Tex.new(output)
      tex.comment "horizontal separator line"
      tex.line 0, y_coordinate, chart.x_axis_length, y_coordinate
      output.string
    end
    
  end
end
