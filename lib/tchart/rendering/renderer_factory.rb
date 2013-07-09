module TChart
  
  #
  # Returns instances of the various object TeX renderers.  Examples
  # include XLabelRenderer, ItemRenderer, etc.
  #
  # Returns singleton instances.  Instances are created lazily, only
  # because the Ruby idiom "@x ||= X.new" makes it easy to do so.
  #
  module RendererFactory
    def self.x_label_renderer
      @x_label_renderer ||= XLabelRenderer.new
    end
    
    def self.chart_item_renderer
      @chart_item_renderer ||= ChartItemRenderer.new
    end
  end
  
end
