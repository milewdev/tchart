require_relative '../../test_helper'

module TChart
  describe XLabel, "render" do
    it "generates TeX code to render an x-axis label" do
      chart = stub( y_axis_length: 100, x_label_y_coordinate: -3, x_label_width: 10, y_axis_length: 30 )
      x_label = XLabel.new(chart, Date.new(1985,1,1), 20)
      tex = Tex.new
      x_label.render(tex)
      tex.to_s.must_equal <<-EOS.unindent
        % 1985
        \\node [xlabel, text width = 10.00mm] at (20.00mm, -3.00mm) {1985};
        \\draw [draw = black!5] (20.00mm, 0.00mm) -- (20.00mm, 30.00mm);
      EOS
    end
  end
end
