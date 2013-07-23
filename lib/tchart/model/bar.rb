module TChart
  
  #
  # A horizontal bar drawn on a chart and that represents
  # a date range.
  #
  class Bar
    
    attr_reader :x_from
    attr_reader :x_to
    attr_reader :y
    attr_reader :style
    
    def initialize(x_from, x_to, y, style)
      @x_from = x_from
      @x_to = x_to
      @y = y
      @style = style
    end
    
    def render(tex)
      tex.bar x_from, x_to, y, style
    end
    
  end
end
