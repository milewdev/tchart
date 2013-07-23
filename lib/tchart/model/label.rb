module TChart
  class Label
    
    attr_reader :x
    attr_reader :y
    attr_reader :width
    attr_reader :style
    attr_reader :text
    
    def initialize(x, y, width, style, text)
      @x = x
      @y = y
      @width = width
      @style = style
      @text = text
    end
    
    def render(tex)
      tex.label x, y, width, style, text
    end
    
  end
end
