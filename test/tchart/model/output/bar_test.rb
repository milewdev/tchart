require_relative '../../../test_helper'

module TChart
  describe Bar, "render" do
    before do
      @tex = TeXBuilder.new
      @bar = Bar.new(xy(0,30), xy(50, 30), "bar_style")
    end
    it "generates TeX code to render itself" do
      @tex.expects(:bar).once
      @bar.render(@tex)
    end
  end
end
