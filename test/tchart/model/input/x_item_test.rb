require_relative '../../../test_helper'

module TChart
  describe XItem, "build" do
    before do
      @layout = stub
      @layout.stubs(:x_label_width).returns 10
      @layout.stubs(:x_label_y_coordinate).returns (-1)
      @layout.stubs(:y_axis_length).returns 50
      @x_item = XItem.new(2001)
    end
    
    it "returns an array containing a label and a grid line" do
      elements = @x_item.build(@layout, 100)
      elements.length.must_equal 2
      elements[0].must_be_kind_of Label
      elements[1].must_be_kind_of GridLine
    end
  end
end
