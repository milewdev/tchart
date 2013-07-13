module TChart
  class SeparatorItemRenderer
    def render(chart, separator_item)
      output = StringIO.new
      tex = Tex.new(output)
      tex.comment "horizontal separator line"
      tex.line 0, separator_item.y_coordinate, chart.x_axis_length, separator_item.y_coordinate
      output.string
    end
  end
end
