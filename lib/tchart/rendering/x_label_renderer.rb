module TChart
  class XLabelRenderer
    def render(chart, x_label)
      <<-EOS.unindent.indent(4)
        % #{x_label.date.year}
        \\draw (#{f x_label.x_coordinate}mm, #{f chart.settings.x_label_y_coordinate}mm) node [xlabel] {#{x_label.date.year}};
        \\draw [draw = black!5] (#{f x_label.x_coordinate}mm, #{f 0}mm) -- (#{f x_label.x_coordinate}mm, #{f chart.y_length}mm);
      EOS
    end

    # f(1.2345) => 1.23
    # TODO: to be moved into base class or utilities module
    def f(number) # => String
      '%.02f' % number
    end
  end
end
