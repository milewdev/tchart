module TChart
  class XLabel
    attr_reader :date
    attr_reader :x_coordinate
    
    def initialize(date, x_coordinate)
      @date = date
      @x_coordinate = x_coordinate
    end
    
    def render(chart)
      RendererFactory.x_label_renderer.render(chart, self)
    end
  end
end
