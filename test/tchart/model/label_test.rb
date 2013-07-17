require_relative '../../test_helper'

module TChart
  describe Label, "render" do
    it "generates TeX code to render and item" do
      label = Label.new(-10, 30, 20, "ylabel", "name")
      tex = Tex.new
      label.render(tex, stub)
      tex.to_s.must_equal "\\node [ylabel, text width = 20.00mm] at (-10.00mm, 30.00mm) {name};\n"
    end
  end
end
