require_relative '../../../test_helper'

module TChart
  describe GridLine, "build_hgridline" do
    it "returns a grid line instance with style 'hgridline'" do
      GridLine.build_hgridline(xy(0,0), xy(0,10)).style.must_equal "hgridline"
    end
  end
  
  describe GridLine, "build_vgridline" do
    it "returns a grid line instance with style 'vgridline'" do
      GridLine.build_vgridline(xy(0,0), xy(10,0)).style.must_equal "vgridline"
    end
  end
  
  describe GridLine, "render" do
    before do
      @tex = Tex.new
      @gridline = GridLine.new(xy(0,0), xy(10,0), "style")
    end
    
    it "generates TeX code to render the grid line" do
      @tex.expects(:line).once
      @gridline.render(@tex)
    end
  end
end
