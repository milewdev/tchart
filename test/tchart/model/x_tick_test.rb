require_relative '../../test_helper'

module TChart
  describe XTick, "render" do
    it "invokes #render on its label and its grid line" do
      label = stub ; label.expects(:render).returns("label code\n")
      grid_line = stub ; grid_line.expects(:render).returns("grid line code\n")
      XTick.new(label, grid_line).render
    end
    it "returns the concatenated label and grid line code" do
      label = stub ; label.stubs(:render).returns("label code\n")
      grid_line = stub ; grid_line.stubs(:render).returns("grid line code\n")
      XTick.new(label, grid_line).render.must_equal "label code\ngrid line code\n"
    end
  end
end
