require_relative '../../test_helper'

module TChart
  describe YItem, "build" do
    
    before do
      @layout = stub
      @layout.stubs(:x_axis_date_range).returns( Date.new(2001,1,1)..Date.new(2003,1,1) )
      @layout.stubs(:y_axis_label_x_coordinate).returns(-10)
      @layout.stubs(:y_axis_label_width).returns(20)
      @layout.stubs(:date_range_to_x_coordinates).returns [0, 50]
      @item = YItem.new("description", "bar_style", [ Date.new(2001,1,1)..Date.new(2001,12,31) ])
      @y = 10
    end
    
    it "returns an array containing a label and bars" do
      elements = @item.build(@layout, @y)
      elements.length.must_equal 2
      elements[0].must_be_kind_of Label
      elements[1].must_be_kind_of Bar
    end
    
  end
end
