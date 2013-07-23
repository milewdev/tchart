require_relative '../../test_helper'

module TChart
  describe SeparatorItem, "calc_layout" do
    it "is defined" do
      SeparatorItem.new.must_respond_to :calc_layout
    end
  end

  describe SeparatorItem, "render" do
    before do
      @tex = Tex.new
      @separator = SeparatorItem.new
    end
    
    it "generates TeX code to render a separator" do
      @tex.expects(:line).once
      @separator.render(@tex)
    end
  end
end
