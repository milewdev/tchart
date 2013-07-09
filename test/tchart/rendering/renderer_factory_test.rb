require_relative '../../test_helper'

module TChart
  describe RendererFactory, "x_label_renderer" do
    it "returns an instance of XLabelRenderer" do
      RendererFactory.x_label_renderer.must_be_instance_of XLabelRenderer
    end
  end
end
