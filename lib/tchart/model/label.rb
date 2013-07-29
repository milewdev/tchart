module TChart
  class Label
    
    attr_reader :coord
    attr_reader :width
    attr_reader :style
    attr_reader :text
    
    def self.build_xlabel(coord, width, text)
      Label.new(coord, width, "xlabel", text)
    end
    
    def self.build_ylabel(coord, width, text)
      Label.new(coord, width, "ylabel", text)
    end
    
    def initialize(coord, width, style, text)
      @coord = coord
      @width = width
      @style = style
      @text = text
    end
    
    def render(tex)
      tex.label coord, width, style, text
    end
    
  end
end
