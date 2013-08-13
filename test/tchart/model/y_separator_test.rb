require_relative '../../test_helper'

module TChart
  describe YSeparator, "build" do
    before do
      @layout = stub( x_axis_length: 100 )
      @y = 10
    end
    it "returns an array containing a horizontal gridline" do
      elements = YSeparator.new.build(@layout, @y)
      elements.length.must_equal 1
      elements[0].must_equal GridLine.new(xy(0,10), xy(100,10))
    end
  end
end
