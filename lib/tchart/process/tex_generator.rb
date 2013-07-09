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
        .map { |item| item.render(@chart) }
        .join("\n")
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
