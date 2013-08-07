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
  
  describe Builder, "add_horizontal_frame" do
    before do
      @y_items = [ stub ]
    end
    
    it "adds top and bottom separator items that complete the frame around the chart" do
      y_items_with_frame = Builder.add_horizontal_frame(@y_items)
      y_items_with_frame.length.must_equal @y_items.length + 2
      y_items_with_frame.first.must_be_kind_of YSeparator
      y_items_with_frame.last.must_be_kind_of YSeparator
    end
  end
end
