require_relative '../../../test_helper'

module TChart
  describe SeparatorItem, "build" do
    it "is defined" do
      SeparatorItem.new.must_respond_to :build
    end
  end

  describe SeparatorItem, "render" do
    before do
      @tex = Tex.new
      @separator = SeparatorItem.new
    end
    
    it "generates TeX code to render a separator" do
      horizontal_gridline = stub ; horizontal_gridline.expects(:render).once
      @separator.stubs(:horizontal_gridline).returns horizontal_gridline
      @separator.render(@tex)
    end
  end
end
