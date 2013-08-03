module TChart
  class Frame
    
    attr_reader :top_gridline
    attr_reader :bottom_gridline
    
    def initialize(layout)
      @top_gridline = GridLine.build_hgridline(xy(0, layout.y_axis_length), xy(layout.x_axis_length, layout.y_axis_length))
      @bottom_gridline = GridLine.build_hgridline(xy(0, 0), xy(layout.x_axis_length, 0))
    end
    
    def render(tex)
      tex.comment "horizontal bottom frame"
      top_gridline.render(tex)
      tex.newline
      tex.comment "horizontal top frame"
      bottom_gridline.render(tex)
      tex.newline
    end
    
  end
end
