module TChart
  class XAxis
    
    attr_reader :labels
    attr_reader :gridlines
    
    def initialize(labels, gridlines)
      @labels = labels
      @gridlines = gridlines
    end
    
    def render(tex)
      tex.comment "x-axis labels"
      labels.each { |label| label.render(tex) }
      tex.newline
      tex.comment "vertical grid lines"
      gridlines.each { |gridline| gridline.render(tex) }
      tex.newline
    end
    
  end
end
