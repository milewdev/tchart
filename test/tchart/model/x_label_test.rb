require_relative '../../test_helper'

module TChart
  describe XLabel, "render" do
    before do
      chart = stub(x_label_y_coordinate: -3, x_label_width: 10, y_axis_length: 30)
      @tex = Tex.new
      @x_label = XLabel.new(chart, Date.new(1985,1,1), 20)
    end
    
    it "generates TeX code to render an x-axis label" do
      @tex.expects(:label).once
      @x_label.vertical_grid_line.expects(:render).once
      @x_label.render(@tex)
    end
  end
end
