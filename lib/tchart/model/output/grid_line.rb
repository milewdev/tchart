module TChart
  class GridLine
    
    attr_reader :from
    attr_reader :to
    attr_reader :style
    
    def self.build_hgridline(from, to)
      GridLine.new(from, to, "hgridline")
    end
    
    def self.build_vgridline(from, to)
      GridLine.new(from, to, "vgridline")
    end
    
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
