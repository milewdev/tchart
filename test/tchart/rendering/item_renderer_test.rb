require_relative '../../test_helper'

module TChart
  describe ItemRenderer, "render" do
    it "generates TeX code to render an item" do
      settings = stub( y_label_width: 20 )
      item = stub( name: "item1", style: "style1", y_coordinate: 30, bar_x_coordinates: [ BarXCoordinates.new(25, 50) ] )
      renderer = ItemRenderer.new(settings)
      renderer.render(item).must_equal <<-EOS.unindent.indent(4)
        % item1
        \\node [ylabel, text width = 20.00mm] at (-10.00mm, 30.00mm) {item1};
        \\node [style1] at (25.00mm, 30.00mm) [minimum width = 50.00mm] {};
      EOS
    end
  end
end
