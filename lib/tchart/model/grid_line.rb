module TChart
  
  #
  # A horizontal or vertical line on the chart that spans the
  # entire width or height of the chart and serves as a reading 
  # aid.  The x and y axes, and the top and and right frame of 
  # the chart are also grid lines.  Responsible for generating 
  # TikZ code to render the grid line.
  #
  class GridLine
    
    #
    # Start coordinate of the line.
    #
    attr_reader :from
    
    #
    # End coordinate of the line.
    #
    attr_reader :to
    
    def initialize(from, to)
      @from = from
      @to = to
    end
    
    #
    # Generate the TikZ code that renders the grid line.
    #
    def render(tex)
      tex.line @from, @to, "gridline"
    end
    
  end
end
