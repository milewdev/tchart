require_relative '../../test_helper'

module TChart
  describe Bar, "render" do
    before do
      @tex = Tex.new
      @bar = Bar.new(Coordinate.new(0,30), Coordinate.new(50, 30), "bar_style")
    end
    
    it "generates TeX code to render itself" do
      @tex.expects(:bar).once
      @bar.render(@tex)
    end
  end
end
