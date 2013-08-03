require_relative '../../../test_helper'

module TChart
  describe Chart, "build" do
    before do
      settings = stub( chart_width: 130, x_label_width: 10, y_label_width: 20, line_height: 10 )
      @items = [ stub, stub ]
      @chart = Chart.new(settings, @items)
      @layout = stub( item_y_coordinates: [20, 10] )
      @chart.stubs(:layout).returns @layout
    end
    it "invokes 'build' on each item and returns an array of the built elements" do
      @items[0].expects(:build).with(@layout, 20).returns [ stub, stub ]
      @items[1].expects(:build).with(@layout, 10).returns [ stub, stub ]
      elements = @chart.build
      elements.length.must_equal 4
    end
  end
end
