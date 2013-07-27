module TChart
  class Frame
    
    attr_reader :top_grid_line
    attr_reader :bottom_grid_line
    
    def initialize(chart)
      @top_grid_line = GridLine.build_hgridline(xy(0, chart.y_axis_length), xy(chart.x_axis_length, chart.y_axis_length))
      @bottom_grid_line = GridLine.build_hgridline(xy(0, 0), xy(chart.x_axis_length, 0))
    end
    
    def render(tex)
      tex.comment "horizontal bottom frame"
      top_grid_line.render(tex)
      tex.newline
      tex.comment "horizontal top frame"
      bottom_grid_line.render(tex)
    end
    
  end
end
