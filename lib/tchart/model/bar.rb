module TChart
  class Bar
    
    attr_reader :from       # Start coordinate of the bar.
    attr_reader :to         # End coordinate of the bar.
    attr_reader :style      # TikZ style (must be defined in TeX document).
    
    def initialize(from, to, style)
      @from = from
      @to = to
      @style = style
    end
    
    def render(tex)
      tex.bar from, to, style
    end
    
  end
end
