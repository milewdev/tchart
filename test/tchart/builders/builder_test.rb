require_relative '../../test_helper'

module TChart
  describe Builder, "build_x_items" do
    before do
      @layout = stub
      @layout.stubs(:x_item_dates).returns [ 2000, 2001 ]
    end
    it "builds a list of x items" do
      x_items = Builder.build_x_items(@layout)
      x_items.length.must_equal 2
      x_items[0].must_equal XItem.new(2000)
      x_items[1].must_equal XItem.new(2001)
    end
  end
  
  describe Builder, "build_frame" do
    before do
      @items = [ stub ]
    end
    it "adds top and bottom separator items that complete the frame around the chart" do
      items_with_frame = Builder.build_frame(@items)
      items_with_frame.length.must_equal @items.length + 2
      items_with_frame.first.must_be_kind_of YSeparator
      items_with_frame.last.must_be_kind_of YSeparator
    end
  end
  
  describe Builder, "build" do
    before do
      @items = [ stub, stub ]
      @layout = stub( y_item_y_coordinates: [20, 10], x_item_dates: [2000, 2001], x_item_x_coordinates: [0, 100], x_item_y_coordinate: -3, x_item_label_width: 10, y_axis_length: 50 )
    end
    it "invokes 'build' on each item and returns an array of the built elements" do
      @items[0].expects(:build).with(@layout, 20).returns [ stub, stub ]
      @items[1].expects(:build).with(@layout, 10).returns [ stub, stub ]
      elements = Builder.build(@layout, @items)
      elements.length.must_equal 8
    end
  end
end
