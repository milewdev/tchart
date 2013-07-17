require_relative '../../test_helper'

module TChart
  describe Bar, "render" do
    it "generates TeX code to render itself" do
      bar = Bar.new(0, 50, 30, "bar_style")
      tex = Tex.new
      bar.render(tex, stub)
      tex.to_s.must_equal "\\node [bar_style] at (25.00mm, 30.00mm) [minimum width = 50.00mm] {};\n"
    end
  end
end
