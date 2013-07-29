module TChart
  class XLabel
    
    attr_reader :label
    attr_reader :vertical_gridline
    
    def initialize(chart, date, x)
      @label = Label.new(xy(x, chart.x_label_y_coordinate), chart.x_label_width, "xlabel", date.year.to_s) # TODO: "xlabel" needs to be read
      @vertical_gridline = GridLine.build_vgridline(xy(x, 0), xy(x, chart.y_axis_length))
    end
    
    def render(tex)
      tex.comment label.text
      label.render(tex)
      vertical_gridline.render(tex)
    end
    
  end
end
