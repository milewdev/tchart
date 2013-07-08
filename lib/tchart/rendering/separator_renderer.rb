module TChart
  class SeparatorRenderer
    def render(separator)
      # TODO: the responsibility of indentation belongs somewhere else?
      <<-EOS.unindent.indent(4)
        % horizontal separator line
        \\draw [draw = black!5] (#{f 0}mm, #{f separator.y_coordinate}mm) -- (#{f separator.x_length}mm, #{f separator.y_coordinate}mm);
      EOS
    end

    # f(1.2345) => 1.23
    # TODO: to be moved into base class or utilities module
    def f(number) # => String
      '%.02f' % number
    end
  end
end
