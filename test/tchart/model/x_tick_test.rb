require_relative '../../test_helper'

module TChart
  describe XTick, "render" do
    
    it "invokes #render on its label and its grid line" do
      label = stub ; label.expects(:render).returns("a")
      grid_line = stub ; grid_line.expects(:render).returns("b")
      XTick.new(label, grid_line).render
    end
    
    it "returns the concatenated label and grid line code" do
      label = stub ; label.stubs(:render).returns("label\n")
      grid_line = stub ; grid_line.stubs(:render).returns("line\n")
      XTick.new(label, grid_line).render.must_equal "label\nline\n"
    end
    
  end
end
