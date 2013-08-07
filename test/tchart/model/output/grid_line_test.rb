require_relative '../../../test_helper'

module TChart
  describe GridLine, "render" do
    before do
      @tex = Tex.new
      @gridline = GridLine.new(xy(0,0), xy(10,0))
    end
    it "generates TeX code to render the grid line" do
      @tex.expects(:line).once
      @gridline.render(@tex)
    end
  end
end
