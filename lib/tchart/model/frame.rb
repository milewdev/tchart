module TChart
  class Frame
    
    attr_reader :x_axis_length
    attr_reader :y_axis_length
    
    def initialize(chart)
      @x_axis_length = chart.x_axis_length
      @y_axis_length = chart.y_axis_length
    end
    
    def render(tex)
      tex.comment "horizontal bottom frame"
      tex.line Coordinate.new(0, 0), Coordinate.new(x_axis_length, 0), "gridline" # TODO: "gridline" needs to be read from somewhere
      tex.newline
      tex.comment "horizontal top frame"
      tex.line Coordinate.new(0, y_axis_length), Coordinate.new(x_axis_length, y_axis_length), "gridline" # TODO: "gridline" needs to be read from somewhere
    end
    
  end
end
