module TChart
  
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
      "\\tikzpicture\n\n" + generate_frame + "\n" + generate_x_axis_labels + "\n" + generate_items + "\n\\endtikzpicture\n"
    end
    
    
    #
    # frame
    #
    
    def generate_frame
      FrameRenderer.new.render(@chart)
    end
    
    
    #
    # x axis
    #
    
    def generate_x_axis_labels
      @chart.x_labels
        .map { |label| label.render(@chart) }
        .join("\n")
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
        generate_separator(item).indent(4)
      else
        ItemRenderer.new.render(@chart, item)
      end
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
