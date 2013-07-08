require_relative '../../test_helper'

module TChart
  describe SeparatorRenderer, "render" do
    it "generates TeX code to render a separator" do
      separator = stub( y_coordinate: 10, x_length: 20 )
      renderer = SeparatorRenderer.new
      renderer.render(separator).must_equal <<-EOS.unindent.indent(4)
        % horizontal separator line
        \\draw [draw = black!5] (0.00mm, 10.00mm) -- (20.00mm, 10.00mm);
      EOS
    end
  end
end
