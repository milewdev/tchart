require_relative '../../test_helper'

module TChart
  describe FrameRenderer, "render" do
    it "generates TeX code to render a chart frame" do
      chart = stub( x_axis_length: 100, y_length: 50 )
      renderer = FrameRenderer.new
      renderer.render(chart).must_equal <<-EOS.unindent.indent(4)
        % horizontal bottom frame
        \\draw [draw = black!5] (0.00mm, 0.00mm) -- (100.00mm, 0.00mm);

        % horizontal top frame
        \\draw [draw = black!5] (0.00mm, 50.00mm) -- (100.00mm, 50.00mm);
      EOS
    end
  end
end
