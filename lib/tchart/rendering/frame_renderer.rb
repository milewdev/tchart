module TChart
  class FrameRenderer
    def render(chart)
      <<-EOS.unindent.indent(4)
        % horizontal bottom frame
        \\draw [draw = black!5] (#{f 0}mm, #{f 0}mm) -- (#{f chart.x_length}mm, #{f 0}mm);

        % horizontal top frame
        \\draw [draw = black!5] (#{f 0}mm, #{f chart.y_length}mm) -- (#{f chart.x_length}mm, #{f chart.y_length}mm);
      EOS
    end

    # f(1.2345) => 1.23
    # TODO: to be moved into base class or utilities module
    def f(number) # => String
      '%.02f' % number
    end
  end
end
