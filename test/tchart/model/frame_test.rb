require_relative '../../test_helper'

module TChart
  describe Frame, "render" do
    it "generates TeX code to render the frame of a chart" do
      chart = stub( x_axis_length: 100, y_axis_length: 50 )
      tex = Tex.new
      Frame.new.render(tex, chart)
      tex.to_s.must_equal <<-EOS.unindent
        % horizontal bottom frame
        \\draw [draw = black!5] (0.00mm, 0.00mm) -- (100.00mm, 0.00mm);

        % horizontal top frame
        \\draw [draw = black!5] (0.00mm, 50.00mm) -- (100.00mm, 50.00mm);
      EOS
    end
  end
end
