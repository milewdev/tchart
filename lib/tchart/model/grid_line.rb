module TChart
  class GridLine
    
    attr_reader :from     # Start coordinate of the line.
    attr_reader :to       # End coordinate of the line.
    
    def initialize(from, to)
      @from = from
      @to = to
    end
    
    def render(tex)
      tex.line from, to, "gridline"
    end
    
  end
end
