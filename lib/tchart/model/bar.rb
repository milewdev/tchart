module TChart
  
  #
  # A bar that represents a date range on the chart.  Responsible 
  # for generating TikZ code to render the bar.
  #
  class Bar
    
    attr_reader :from
    attr_reader :to
    attr_reader :style    # TikZ style, must be defined in encompasing TeX document.
    
    def initialize(from, to, style)
      @from = from
      @to = to
      @style = style
    end
    
    def render(tex)
      tex.bar @from, @to, @style
    end
    
  end
end
