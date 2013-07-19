require_relative '../../test_helper'

module TChart
  describe GridLine, "render" do
    
    it "calls Tex.line to render a line" do
      from, to, style = Coordinate.new(0,0), Coordinate.new(10,0), "grid_style"
      Tex.expects(:line).with(from, to, style)
      GridLine.new(from, to, style).render
    end
    
    it "returns the output from Tex.line" do
      Tex.stubs(:line).returns("some TeX code")
      GridLine.new(Coordinate.new(0,0), Coordinate.new(10,0), "grid_style").render.must_equal "some TeX code"
    end
    
  end
end
