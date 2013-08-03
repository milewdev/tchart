require_relative '../../../test_helper'

module TChart
  describe Chart, "build" do
    it "invokes 'build' on each item" do
      settings = stub( chart_width: 130, x_label_width: 10, y_label_width: 20, line_height: 10 )
      items = [ stub, stub ]
      chart = Chart.new(settings, items)
      layout = stub( item_y_coordinates: [20, 10] )
      chart.stubs(:layout).returns layout
      items[0].expects(:build).with(chart, 20)
      items[1].expects(:build).with(chart, 10)
      chart.build
    end
  end
  
  describe Chart, "date_to_x_coordinate" do
    it "converts a date to its equivalent x-coordinate on the chart" do
      settings = stub( chart_width: 130, x_label_width: 10, y_label_width: 20, line_height: 10 )
      chart = Chart.new(settings, [stub, stub, stub])
      layout = stub( x_axis_dates: (2001..2002).step(1).to_a, x_axis_length: 100 )
      chart.stubs(:layout).returns layout
      chart.date_to_x_coordinate(Date.new(2001,1,1)).must_equal 0
      chart.date_to_x_coordinate(Date.new(2001,6,30)).must_be_close_to 50, 1
      chart.date_to_x_coordinate(Date.new(2002,1,1)).must_equal 100
    end
  end
end
