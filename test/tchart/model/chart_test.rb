require_relative '../../test_helper'

module TChart
  describe Chart, "x_axis_length" do
    it "returns the correct length" do
      settings = stub( chart_width: 130, x_label_width: 10, y_label_width: 20, line_height: 10 )
      chart = Chart.new(settings, [stub, stub, stub])
      chart.x_axis_length.must_equal settings.chart_width - settings.y_label_width - settings.x_label_width
    end
  end
  
  describe Chart, "y_axis_length" do
    it "returns the correct length" do
      settings = stub( chart_width: 130, x_label_width: 10, y_label_width: 20, line_height: 10 )
      items = [ stub, stub ]
      chart = Chart.new(settings, items)
      chart.y_axis_length.must_equal settings.line_height * (items.length + 1)
    end
  end
  
  describe Chart, "x_axis_labels" do
    it "calls XLabelsBuilder#build" do
      settings = stub( chart_width: 130, x_label_width: 10, y_label_width: 20, line_height: 10 )
      chart = Chart.new(settings, [stub, stub, stub])
      XLabelsBuilder.expects(:build).with(chart)
      chart.x_axis_labels
    end
    it "caches the result" do
      settings = stub( chart_width: 130, x_label_width: 10, y_label_width: 20, line_height: 10 )
      chart = Chart.new(settings, [stub, stub, stub])
      XLabelsBuilder.expects(:build).once.with(chart).returns(stub)
      chart.x_axis_labels
      chart.x_axis_labels
    end
  end
  
  describe Chart, "y_axis_label_x_coordinate" do
    it "returns the correct value" do
      settings = stub( chart_width: 130, x_label_width: 10, y_label_width: 20, line_height: 10 )
      chart = Chart.new(settings, [stub, stub, stub])
      chart.y_axis_label_x_coordinate.must_equal (-20 / 2)
    end
  end
  
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
      chart.stubs(:x_axis_labels).returns([ stub(date: Date.new(2001,1,1)), stub(date: Date.new(2002,1,1)) ])
      chart.date_to_x_coordinate(Date.new(2001,1,1)).must_equal 0
      chart.date_to_x_coordinate(Date.new(2001,6,30)).must_be_close_to 50, 1
      chart.date_to_x_coordinate(Date.new(2002,1,1)).must_equal 100
    end
  end
end
