module TChart
  class Frame
    def render(tex, chart)
      tex.comment "horizontal bottom frame"
      tex.line 0, 0, chart.x_axis_length, 0
      tex.newline
      tex.comment "horizontal top frame"
      tex.line 0, chart.y_axis_length, chart.x_axis_length, chart.y_axis_length
    end
  end
end
