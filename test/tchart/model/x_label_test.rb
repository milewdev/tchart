require_relative '../../test_helper'

module TChart
  describe XLabel, "render" do
    before do
      @x_label = XLabel.new(Date.today, 42)
      @chart = stub
      @renderer = stub
    end
    it "invokes RendererFactory#x_label_renderer" do
      @renderer.stubs(:render).with(@chart, @x_label)
      RendererFactory.expects(:x_label_renderer).returns(@renderer)
      @x_label.render(@chart)
    end
    it "invokes XLabelRenderer#render" do
      @renderer.expects(:render).with(@chart, @x_label)
      RendererFactory.stubs(:x_label_renderer).returns(@renderer)
      @x_label.render(@chart)
    end
  end
end
