module TChart
  class Label
    
    attr_reader :coord      # Hor. and ver. mid-point where label is located.
    attr_reader :width      # Width of the label (required for text justification).
    attr_reader :style      # TikZ style (must be defined in TeX document).
    attr_reader :text       # Content of the label.
    
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
