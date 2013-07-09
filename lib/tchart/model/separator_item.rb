module TChart
  class SeparatorItem
    attr_accessor :y_coordinate
    
    def render(chart)
      RendererFactory.separator_item_renderer.render(chart, self)
    end
  end
end
