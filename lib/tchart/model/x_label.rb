module TChart
  class XLabel
    
    attr_reader :date
    attr_reader :coord
    attr_reader :width
    attr_reader :vertical_grid_line
    
    def initialize(chart, date, x)
      @date = date
      @coord = Coordinate.new(x, chart.x_label_y_coordinate)
      @width = chart.x_label_width
      @vertical_grid_line = GridLine.new(Coordinate.new(x, 0), Coordinate.new(x, chart.y_axis_length), "gridline") # TODO: "gridline" needs to be read from
    end
    
    def render(tex)
      tex.comment date.year
      tex.label coord, width, 'xlabel', date.year
      vertical_grid_line.render(tex)
    end
    
  end
end
