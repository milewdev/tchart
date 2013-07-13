require_relative '../../test_helper'

module TChart
  describe RendererFactory, "separator_item_renderer" do
    it "returns an instance of SeparatorItemRenderer" do
      RendererFactory.separator_item_renderer.must_be_instance_of SeparatorItemRenderer
    end
    
    it "returns the same instance of SeparatorItemRenderer each time it is invoked" do
      RendererFactory.separator_item_renderer.must_be_same_as RendererFactory.separator_item_renderer
    end
  end
end
