require_relative '../../test_helper'

module TChart
  describe Frame, "render" do
    before do
      chart = stub(x_axis_length: 100, y_axis_length: 50)
      @tex = Tex.new
      @frame = Frame.new(chart)
    end
    
    it "generates TeX code to render the frame of a chart" do
      @frame.top_grid_line.expects(:render).once
      @frame.bottom_grid_line.expects(:render).once
      @frame.render(@tex)
    end
  end
end
