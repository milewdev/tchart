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
    
    def render
      tex = Tex.new
      tex.line from.x, from.y, to.x, to.y
      tex.to_s
    end
  end
end
