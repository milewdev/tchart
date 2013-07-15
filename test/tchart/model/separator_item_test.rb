require_relative '../../test_helper'

module TChart
  describe SeparatorItem, "calc_layout" do
    it "is defined" do
      SeparatorItem.new.must_respond_to :calc_layout
    end
  end

  describe SeparatorItem, "render" do
    it "generates TeX code to render a separator" do
      chart = stub( x_axis_length: 20 )
      separator = SeparatorItem.new
      separator.calc_layout(chart, 10)
      tex = Tex.new
      separator.render(tex, chart)
      tex.to_s.must_equal <<-EOS.unindent
        % horizontal separator line
        \\draw [draw = black!5] (0.00mm, 10.00mm) -- (20.00mm, 10.00mm);
      EOS
    end
  end
end
