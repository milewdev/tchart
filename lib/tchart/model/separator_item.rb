module TChart
  class SeparatorItem
    attr_accessor :y_coordinate

    attr_reader :date_ranges        # TODO: this smells a bit...
    attr_accessor :bar_x_coordinates  # TODO: this smells a bit too...
    
    def initialize
      @date_ranges = []
    end
    
    def render(chart)
      RendererFactory.separator_item_renderer.render(chart, self)
    end
  end
end
