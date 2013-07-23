module TChart
  
  #
  # A horizontal bar drawn on a chart and that represents
  # a date range.
  #
  class Bar
    
    attr_reader :from
    attr_reader :to
    attr_reader :style
    
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
