require_relative '../../test_helper'

module TChart
  describe RendererFactory, "x_label_renderer" do
    it "returns an instance of XLabelRenderer" do
      RendererFactory.x_label_renderer.must_be_instance_of XLabelRenderer
    end
    it "returns the same instance of XLabelRenderer each time it is invoked" do
      RendererFactory.x_label_renderer.must_be_same_as RendererFactory.x_label_renderer
    end
  end
  
  describe RendererFactory, "item_renderer" do
    it "returns an instance of ItemRenderer" do
      RendererFactory.item_renderer.must_be_instance_of ItemRenderer
    end
    it "returns the same instance of XLabelRenderer each time it is invoked" do
      RendererFactory.item_renderer.must_be_same_as RendererFactory.item_renderer
    end
  end
end
