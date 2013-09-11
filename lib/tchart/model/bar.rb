module TChart
  
  #
  # A bar that represents a date range on the chart.  Responsible 
  # for generating TikZ code to render the bar.
  #
  class Bar
    
    #
    # Start coordinate of the bar on the chart.
    #
    attr_reader :from
    
    #
    # End coordinate of the bar on the chart.
    #
    attr_reader :to

    #
    # TikZ style (must be defined in the TeX document that embeds the generated chart).
    #
    attr_reader :style
    
    def initialize(from, to, style)
      @from = from
      @to = to
      @style = style
    end
    
    #
    # Generate the TikZ code that renders the bar.
    #
    def render(tex)
      tex.bar @from, @to, @style
    end
    
  end
end
