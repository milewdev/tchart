require_relative '../../test_helper'

module TChart
  describe GridLine, "render" do
    before do
      @tex = Tex.new
      @grid_line = GridLine.new(Coordinate.new(0,0), Coordinate.new(10,0), "style")
    end
    
    it "generates TeX code to render the grid line" do
      @tex.expects(:line).once
      @grid_line.render(@tex)
    end
  end
end
