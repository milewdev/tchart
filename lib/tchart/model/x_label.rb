module TChart
  class XLabel
    
    attr_reader :date
    attr_reader :x_coordinate
    attr_reader :y_coordinate
    attr_reader :width
    attr_reader :grid_line_length
    
    def initialize(chart, date, x_coordinate)
      @date = date
      @x_coordinate = x_coordinate
      @y_coordinate = chart.x_label_y_coordinate
      @width = chart.x_label_width
      @grid_line_length = chart.y_axis_length
    end
    
    def render(tex)
      tex.comment date.year
      tex.label x_coordinate, y_coordinate, width, 'xlabel', date.year
      tex.line Coordinate.new(x_coordinate, 0), Coordinate.new(x_coordinate, grid_line_length)
    end
    
  end
end
