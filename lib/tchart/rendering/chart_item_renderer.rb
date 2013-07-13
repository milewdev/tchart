module TChart
  class ChartItemRenderer
    def render(chart, item)
      output = StringIO.new
      tex = Tex.new(output)
      tex.comment item.name
      mid_point, width = chart.settings.y_label_width / -2.0, chart.settings.y_label_width
      tex.label mid_point, item.y_coordinate, width, 'ylabel', item.name
      item.bar_x_coordinates
        .map { |bar_x_coordinates| tex.bar(bar_x_coordinates.from, bar_x_coordinates.to, item.y_coordinate, item.style) }
        .join
      output.string
    end
  end
end
