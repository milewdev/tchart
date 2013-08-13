module TChart
  class GridLine
    
    attr_reader :from
    attr_reader :to
    
    def initialize(from, to)
      @from = from
      @to = to
    end
    
    def render(tex)
      tex.line from, to, "gridline"
    end
    
  end
end
