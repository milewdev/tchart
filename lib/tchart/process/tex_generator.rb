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
      output = StringIO.new
      tex = Tex.new(output)
      chart.frame.render(tex, chart)
      output.string
    end
    
    def self.generate_x_axis_labels(chart)
      output = StringIO.new
      tex = Tex.new(output)
      chart.x_axis_labels.each { |label| label.render(tex, chart) }
      output.string
    end
    
    def self.generate_items(chart)
      output = StringIO.new
      tex = Tex.new(output)
      chart.items.each { |item| item.render(tex, chart) }
      output.string
    end

  end

end
