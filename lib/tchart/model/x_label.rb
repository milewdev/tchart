module TChart
  class XLabel
    attr_reader :date
    attr_reader :x_coordinate
    
    def initialize(date, x_coordinate)
      @date = date
      @x_coordinate = x_coordinate
    end
    
    def render(tex, chart)
      tex.comment @date.year
      tex.label @x_coordinate, chart.settings.x_label_y_coordinate, chart.settings.x_label_width, 'xlabel', @date.year
      tex.line @x_coordinate, 0, @x_coordinate, chart.y_axis_length
    end
  end
end
