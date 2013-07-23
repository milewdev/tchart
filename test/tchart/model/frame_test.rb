require_relative '../../test_helper'

module TChart
  describe Frame, "render" do
    before do
      chart = stub(x_axis_length: 100, y_axis_length: 50)
      @tex = Tex.new
      @frame = Frame.new(chart)
    end
    
    it "generates TeX code to render the frame of a chart" do
      @tex.expects(:line).twice
      @frame.render(@tex)
    end
  end
end
