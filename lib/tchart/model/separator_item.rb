module TChart
  class SeparatorItem
    attr_reader :y_coordinate
    
    def initialize(y_coordinate)
      @y_coordinate = y_coordinate
    end
    
    def render(chart)
      RendererFactory.separator_item_renderer.render(chart, self)
    end
  end
end
