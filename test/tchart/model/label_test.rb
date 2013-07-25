require_relative '../../test_helper'

module TChart
  describe Label, "render" do
    before do
      @tex = Tex.new
      @label = Label.new(xy(-10,20), xy(30,20), "ylabel", "name")
    end
    
    it "generates TeX code to render and item" do
      @tex.expects(:label)
      @label.render(@tex)
    end
  end
end
