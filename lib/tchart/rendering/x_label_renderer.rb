module TChart
  class XLabelRenderer
    def render(chart, x_label)
      output = StringIO.new
      tex output do
        # TODO: remove .to_s
        comment x_label.date.year.to_s
        label   x_label.x_coordinate, chart.settings.x_label_y_coordinate, chart.settings.x_label_width, 'xlabel', x_label.date.year.to_s
        line    x_label.x_coordinate, 0, x_label.x_coordinate, chart.y_axis_length
      end
      output.string
    end
  end
end
