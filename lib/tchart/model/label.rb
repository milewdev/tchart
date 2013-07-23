module TChart
  class Label
    
    attr_reader :coord
    attr_reader :width
    attr_reader :style
    attr_reader :text
    
    def initialize(coord, width, style, text)
      @coord = coord
      @width = width
      @style = style
      @text = text
    end
    
    def render(tex)
      tex.label coord.x, coord.y, width, style, text
    end
    
  end
end
