module TChart
  class XLabel
    
    attr_reader :date
    attr_reader :coord
    attr_reader :width
    attr_reader :grid_line_length
    
    def initialize(chart, date, x_coordinate)
      @date = date
      @coord = Coordinate.new(x_coordinate, chart.x_label_y_coordinate)
      @width = chart.x_label_width
      @grid_line_length = chart.y_axis_length
    end
    
    def render(tex)
      tex.comment date.year
      tex.label coord, width, 'xlabel', date.year
      #tex.line Coordinate.new(coord.x, 0), Coordinate.new(coord.x, grid_line_length), "gridline" # TODO: "gridline" needs to be read from somewhere
    end
    
  end
end
