require_relative '../../../test_helper'

module TChart
  describe Chart, "calc_layout" do
    it "invokes 'calc_layout' on each item" do
      settings = stub( chart_width: 130, x_label_width: 10, y_label_width: 20, line_height: 10 )
      items = [ stub, stub ]
      chart = Chart.new(settings, items)
      items[0].expects(:calc_layout).with(chart, 20)
      items[1].expects(:calc_layout).with(chart, 10)
      chart.calc_layout
    end
  end
  
  describe Chart, "date_to_x_coordinate" do
    it "converts a date to its equivalent x-coordinate on the chart" do
      settings = stub( chart_width: 130, x_label_width: 10, y_label_width: 20, line_height: 10 )
      chart = Chart.new(settings, [stub, stub, stub])
      chart.stubs(:x_axis_length).returns(100)
      chart.stubs(:x_axis_dates).returns (2001..2002).step(1).to_a
      chart.date_to_x_coordinate(Date.new(2001,1,1)).must_equal 0
      chart.date_to_x_coordinate(Date.new(2001,6,30)).must_be_close_to 50, 1
      chart.date_to_x_coordinate(Date.new(2002,1,1)).must_equal 100
    end
  end
end
