require_relative '../../../test_helper'

module TChart
  describe Chart, "build" do
    before do
      @x_items = [ stub, stub ]
      @y_items = [ stub, stub ]
      @layout = stub( y_item_y_coordinates: [20, 10], x_item_dates: [2000, 2001], x_item_x_coordinates: [0, 100], x_item_y_coordinate: -3, x_item_label_width: 10 )
      @chart = Chart.new(@layout, @x_items, @y_items)
    end
    it "invokes 'build' on each item and returns an array of the built elements" do
      @x_items[0].expects(:build).with(@layout, 0).returns [ stub, stub ]
      @x_items[1].expects(:build).with(@layout, 100).returns [ stub, stub ]
      @y_items[0].expects(:build).with(@layout, 20).returns [ stub, stub ]
      @y_items[1].expects(:build).with(@layout, 10).returns [ stub, stub ]
      elements = @chart.build
      elements.length.must_equal 8
    end
  end
end
