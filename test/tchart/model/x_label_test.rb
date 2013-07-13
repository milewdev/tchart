require_relative '../../test_helper'

module TChart
  describe XLabel, "render" do
    it "generates TeX code to render an x-axis label" do
      settings = stub( x_label_y_coordinate: -3, x_label_width: 10 )
      chart = stub( settings: settings, y_axis_length: 100 )
      x_label = XLabel.new( Date.new(1985,1,1), 20 )
      x_label.render(chart).must_equal <<-EOS.unindent
        % 1985
        \\node [xlabel, text width = 10.00mm] at (20.00mm, -3.00mm) {1985};
        \\draw [draw = black!5] (20.00mm, 0.00mm) -- (20.00mm, 100.00mm);
      EOS
    end
  end
end
