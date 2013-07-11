module TChart
  
  #
  # Generates the TeX code representation of a chart.  The  
  # generated code uses the TikZ TeX / LaTeX graphics package.
  #
  # See: http://en.wikipedia.org/wiki/PGF/TikZ
  #
  class TeXGenerator
    
    def self.generate(chart)
      "\\tikzpicture\n\n" + generate_frame(chart) + "\n" + generate_x_axis_labels(chart) + "\n" + generate_items(chart) + "\n\\endtikzpicture\n"
    end
    
    def self.generate_frame(chart)
      FrameRenderer.new.render(chart)
    end
    
    def self.generate_x_axis_labels(chart)
      chart.x_labels
        .map { |label| label.render(chart) }
        .join("\n")
    end
    
    def self.generate_items(chart)
      chart.items
        .map { |item| item.render(chart) }
        .join("\n")
    end

  end

end
