module Resume
  
  #
  # Generates the TeX code representation of a chart.  The  
  # generated code uses the TikZ TeX / LaTeX graphics package.
  #
  # See: http://en.wikipedia.org/wiki/PGF/TikZ
  #
  class TeXGenerator
    
    def self.generate(settings, chart)
      TeXGenerator.new(settings, chart).generate
    end
    
    def initialize(settings, chart)
      @settings = settings
      @chart = chart
    end
    
    def generate
      "\\tikzpicture\n\n" + (generate_frame + "\n" + generate_x_axis_labels + "\n" + generate_items).indent(4) + "\n\\endtikzpicture\n"
    end
    
    
    #
    # frame
    #
    
    def generate_frame
      <<-EOS.unindent
        % horizontal bottom frame
        \\draw [draw = black!5] (#{f 0}mm, #{f 0}mm) -- (#{f @chart.x_length}mm, #{f 0}mm);

        % horizontal top frame
        \\draw [draw = black!5] (#{f 0}mm, #{f @chart.y_length}mm) -- (#{f @chart.x_length}mm, #{f @chart.y_length}mm);
      EOS
    end
    
    
    #
    # x axis
    #
    
    def generate_x_axis_labels
      @chart.x_labels
        .map { |label| generate_x_axis_label(label) }
        .join("\n")
    end
    
    def generate_x_axis_label(label)
      <<-EOS.unindent
        % #{label.date.year}
        \\draw (#{f label.x_coordinate}mm, #{f @settings.x_label_y_coordinate}mm) node [xlabel] {#{label.date.year}};
        \\draw [draw = black!5] (#{f label.x_coordinate}mm, #{f 0}mm) -- (#{f label.x_coordinate}mm, #{f @chart.y_length}mm);
      EOS
    end
    
    
    #
    # items
    #
    
    def generate_items
      @chart.chart_items
        .map { |item| generate_item(item) }
        .join("\n")
    end
    
    def generate_item(item)
      if item.name.start_with?('---')
        generate_separator(item)
      else
        generate_item_comment(item) + generate_item_y_label(item) + generate_item_bars(item)
      end
    end

    def generate_item_comment(item)
      "% #{escape_tex_special_chars item.name}\n"
    end
    
    def generate_item_y_label(item)
      mid_point, width = @settings.y_label_width / -2.0, @settings.y_label_width
      "\\node [ylabel, text width = #{f width}mm] at (#{f mid_point}mm, #{f item.y_coordinate}mm) {#{escape_tex_special_chars item.name}};\n"
    end
    
    def generate_item_bars(item)
      item.bar_x_coordinates.map { |bar_x_coordinates| generate_item_bar(item, bar_x_coordinates) }.join
    end
    
    def generate_item_bar(item, bar_x_coordinates)
      "\\node [#{item.style}] at (#{f bar_x_coordinates.mid_point}mm, #{f item.y_coordinate}mm) [minimum width = #{f bar_x_coordinates.width}mm] {};\n"
    end
    
    def generate_separator(item)
      <<-EOS.unindent
        % horizontal separator line
        \\draw [draw = black!5] (#{f 0}mm, #{f item.y_coordinate}mm) -- (#{f @chart.x_length}mm, #{f item.y_coordinate}mm);
      EOS
    end
    
    
    #
    # misc
    #
    # Note: these could be class methods but then we'd have to write, for example,
    # TeXGenerator.f(...) instead of just f(...).
    #
    
    # f(1.2345) => 1.23
    def f(number) # => String
      '%.02f' % number
    end
    
    # escape_tex_special_chars("a#b&c") => "a\#b\&c"
    def escape_tex_special_chars(text) # => String
      text.gsub(/([#&])/, '\\\\\\1')
    end
    
  end
end
