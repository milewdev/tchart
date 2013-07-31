module TChart
  class XAxis
    
    attr_reader :labels
    attr_reader :gridlines
    
    def initialize(labels, gridlines)
      @labels = labels
      @gridlines = gridlines
    end
    
    def render(tex)
      render_labels(tex)
      render_gridlines(tex)
    end
    
  private
    
    def render_labels(tex)
      tex.comment "x-axis labels"
      labels.each { |label| label.render(tex) }
      tex.newline
    end
    
    def render_gridlines(tex)
      tex.comment "vertical grid lines"
      gridlines.each { |gridline| gridline.render(tex) }
      tex.newline
    end
    
  end
end
