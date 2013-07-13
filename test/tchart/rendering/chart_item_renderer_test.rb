require_relative '../../test_helper'

module TChart
  describe ChartItemRenderer, "render" do
    it "generates TeX code to render an item" do
      settings = stub( y_label_width: 20 )
      chart = stub(settings: settings)
      item = stub( name: "item", style: "style", y_coordinate: 30, bar_x_coordinates: [ BarXCoordinates.new(0, 50) ] )
      ChartItemRenderer.new.render(chart, item).must_equal <<-EOS.unindent
        % item
        \\node [ylabel, text width = 20.00mm] at (-10.00mm, 30.00mm) {item};
        \\node [style] at (25.00mm, 30.00mm) [minimum width = 50.00mm] {};
      EOS
    end
  end
end
