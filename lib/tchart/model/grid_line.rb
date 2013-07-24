module TChart
  class GridLine
    
    attr_reader :from
    attr_reader :to
    attr_reader :style
    
    def initialize(from, to, style)
      @from = from
      @to = to
      @style = style
    end
    
    def render(tex)
      tex.line from, to, style
    end
    
  end
end
