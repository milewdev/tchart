module TChart
  class SeparatorItem
    
    attr_reader :y_coordinate
    attr_reader :date_ranges        # TODO: smell
    
    def initialize
      @date_ranges = []
    end
    
    def calc_layout(chart, y_coordinate)
      @y_coordinate = y_coordinate
    end
    
    def render(chart)
      RendererFactory.separator_item_renderer.render(chart, self)
    end
    
  end
end
