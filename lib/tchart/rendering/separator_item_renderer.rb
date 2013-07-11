module TChart
  class SeparatorItemRenderer
    def render(chart, separator_item)
      # TODO: the responsibility of indentation belongs somewhere else?
      <<-EOS.unindent.indent(4)
        % horizontal separator line
        \\draw [draw = black!5] (#{f 0}mm, #{f separator_item.y_coordinate}mm) -- (#{f chart.x_axis_length}mm, #{f separator_item.y_coordinate}mm);
      EOS
    end

    # f(1.2345) => 1.23
    # TODO: to be moved into base class or utilities module
    def f(number) # => String
      '%.02f' % number
    end
  end
end
