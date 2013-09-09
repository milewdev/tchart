require_relative '../../test_helper'

module TChart
  describe Label, "build_xlabel" do
    it "returns a label with style 'xlabel'" do
      Label.build_xlabel(xy(4,2), 42, "text").style.must_equal "xlabel"
    end
  end
  
  
  describe Label, "build_ylabel" do
    it "returns a label with style 'ylabel'" do
      Label.build_ylabel(xy(4,2), 42, "text").style.must_equal "ylabel"
    end
  end
  
  
  describe Label, "render" do
    
    before do
      @tex = TeXBuilder.new
      @label = Label.build_ylabel(xy(-10,20), xy(30,20), "description")
    end
    
    it "generates TikZ code to render and item" do
      @tex.expects(:label)
      @label.render(@tex)
    end
    
  end
end
