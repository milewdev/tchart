require_relative '../../test_helper'

module TChart
  describe GridLine, "render" do
    it "calls Tex#line to render a line" do
      Tex.any_instance.expects(:line).with(0,0,10,0)
      GridLine.new(Coordinate.new(0,0), Coordinate.new(10,0), "grid_style").render
    end
    it "returns the output from Tex#line" do
      Tex.any_instance.stubs(:to_s).returns("some TeX code")
      GridLine.new(Coordinate.new(0,0), Coordinate.new(10,0), "grid_style").render.must_equal "some TeX code"
    end
  end
end
