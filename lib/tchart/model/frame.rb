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
      tex.line 0, 0, x_axis_length, 0
      tex.newline
      tex.comment "horizontal top frame"
      tex.line 0, y_axis_length, x_axis_length, y_axis_length
    end
    
  end
end
