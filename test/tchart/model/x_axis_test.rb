require_relative '../../test_helper'

module TChart
  describe XAxis, "render" do
    it "invokes render on its labels and gridlines" do
      label = stub ; label.expects(:render)
      gridline = stub ; gridline.expects(:render)
      x_axis = XAxis.new([label], [gridline])
      tex = Tex.new
      x_axis.render(tex)
    end
  end
end
