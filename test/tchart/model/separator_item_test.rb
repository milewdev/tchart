require_relative '../../test_helper'

module TChart
  describe SeparatorItem, "calc_layout" do
    it "is defined" do
      SeparatorItem.new.must_respond_to :calc_layout
    end
  end
  
  describe SeparatorItem, "render" do
    before do
      @separator_item = SeparatorItem.new
      @chart = stub
      @renderer = stub
    end
    it "invokes RendererFactory#separator_item_renderer" do
      @renderer.stubs(:render).with(@chart, @separator_item)
      RendererFactory.expects(:separator_item_renderer).returns(@renderer)
      @separator_item.render(@chart)
    end
    it "invokes SeparatorItemRenderer#render" do
      @renderer.expects(:render).with(@chart, @separator_item)
      RendererFactory.stubs(:separator_item_renderer).returns(@renderer)
      @separator_item.render(@chart)
    end
  end
end
