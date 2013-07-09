require_relative '../../test_helper'

module TChart
  describe ChartItem, "render" do
    before do
      @chart_item = ChartItem.new("name", "style", [ Date.new(2000,1,1)..Date.new(2000,12,31) ])
      @chart = stub
      @renderer = stub
    end
    it "invokes RendererFactory#chart_item_renderer" do
      @renderer.stubs(:render).with(@chart, @chart_item)
      RendererFactory.expects(:chart_item_renderer).returns(@renderer)
      @chart_item.render(@chart)
    end
    it "invokes ChartItemRenderer#render" do
      @renderer.expects(:render).with(@chart, @chart_item)
      RendererFactory.stubs(:chart_item_renderer).returns(@renderer)
      @chart_item.render(@chart)
    end
  end
end
