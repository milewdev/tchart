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
      chart.stubs(:x_axis_dates).returns (2001..2002).step(1).to_a
      chart.date_to_x_coordinate(Date.new(2001,1,1)).must_equal 0
      chart.date_to_x_coordinate(Date.new(2001,6,30)).must_be_close_to 50, 1
      chart.date_to_x_coordinate(Date.new(2002,1,1)).must_equal 100
    end
  end
  
  describe Chart, "x_axis_dates" do
    before do
      @chart = Chart.new(stub, stub)
    end
    
    it "returns the correct dates when the chart items date range is less than 10 years" do
      @chart.stubs(:items_date_range).returns Date.new(2000,3,17)..Date.new(2004,10,4)
      @chart.x_axis_dates.must_equal (2000..2005).step(1).to_a
    end
    it "calculates the correct range and interval when the chart items date range is 10 years" do
      @chart.stubs(:items_date_range).returns Date.new(2000,3,17)..Date.new(2009,10,4)
      @chart.x_axis_dates.must_equal (2000..2010).step(1).to_a
    end
    it "calculates the correct range and interval when the chart items date range is 11 years" do
      @chart.stubs(:items_date_range).returns Date.new(2000,3,17)..Date.new(2010,10,4)
      @chart.x_axis_dates.must_equal (2000..2015).step(5).to_a
    end
    it "calculates the correct range and interval when the chart items date range is less than 50 years" do
      @chart.stubs(:items_date_range).returns Date.new(2000,3,17)..Date.new(2044,10,4)
      @chart.x_axis_dates.must_equal (2000..2045).step(5).to_a
    end
    it "calculates the correct range and interval when the chart items date range is 50 years" do
      @chart.stubs(:items_date_range).returns Date.new(2000,3,17)..Date.new(2049,10,4)
      @chart.x_axis_dates.must_equal (2000..2050).step(5).to_a
    end
    it "calculates the correct range and interval when the chart items date range is less than 60 years" do
      @chart.stubs(:items_date_range).returns Date.new(2000,3,17)..Date.new(2054,10,4)
      @chart.x_axis_dates.must_equal (2000..2060).step(10).to_a
    end
    it "calculates the correct range and interval when the chart items date range is 60 years" do
      @chart.stubs(:items_date_range).returns Date.new(2000,3,17)..Date.new(2059,10,4)
      @chart.x_axis_dates.must_equal (2000..2060).step(10).to_a
    end
  end
  
  describe Chart, "x_axis_label_x_coordinates" do
    before do
      @chart = Chart.new(stub, stub)
    end
    
    it "returns an array of x coordinates" do
      @chart.stubs(:x_axis_length).returns 100
      @chart.stubs(:x_axis_dates).returns (2000..2005).step(1)
      @chart.x_axis_label_x_coordinates.inspect.must_equal (0..100).step(20.0).inspect
    end
  end

  describe Chart, "items_date_range" do
    it "returns a range from the earliest chart item start date to the latest chart item end date" do
      item1 = stub( :date_ranges => [Date.new(2000, 11, 1)..Date.new(2005, 3, 21)] )
      item2 = stub( :date_ranges => [Date.new(2002, 4, 17)..Date.new(2008, 3, 30)] )
      chart = Chart.new(stub, [item1, item2])
      chart.items_date_range.must_equal Date.new(2000, 11, 1)..Date.new(2008, 3, 30)
    end
    it "returns 1st January to 31st December when chart items is empty" do
      chart = Chart.new(stub, [])
      this_year = Date.today.year
      chart.items_date_range.must_equal Date.new(this_year,1,1)..Date.new(this_year,12,31)
    end
    it "returns 1st January to 31st December when none of the chart items have date ranges" do
      item1 = stub( :date_ranges => [] )
      item2 = stub( :date_ranges => [] )
      chart = Chart.new(stub, [item1, item2])
      this_year = Date.today.year
      chart.items_date_range.must_equal Date.new(this_year,1,1)..Date.new(this_year,12,31)
    end
  end
  
  describe Chart, "x_axis_labels" do
    before do
      @chart = Chart.new(stub, [stub, stub])
      @chart.stubs(:x_label_y_coordinate).returns (-3)
      @chart.stubs(:x_label_width).returns 10
      @chart.stubs(:line_height).returns 4
      @chart.stubs(:x_axis_dates).returns [2000, 2001, 2002, 2003, 2004]
      @chart.stubs(:x_axis_label_x_coordinates).returns [0, 25, 50, 75, 100]
    end
    it "builds the correct number of labels" do
      @chart.x_axis_labels.length.must_equal 5
    end
    it "builds labels with the correct text" do
      @chart.x_axis_labels[0].label.text.must_equal "2000"
      @chart.x_axis_labels[1].label.text.must_equal "2001"
      @chart.x_axis_labels[2].label.text.must_equal "2002"
      @chart.x_axis_labels[3].label.text.must_equal "2003"
      @chart.x_axis_labels[4].label.text.must_equal "2004"
    end
    it "builds labels with the correct x-coordinate" do
      @chart.x_axis_labels[0].label.coord.x.must_equal 0
      @chart.x_axis_labels[1].label.coord.x.must_equal 25
      @chart.x_axis_labels[2].label.coord.x.must_equal 50
      @chart.x_axis_labels[3].label.coord.x.must_equal 75
      @chart.x_axis_labels[4].label.coord.x.must_equal 100
    end
  end
  
  describe Chart, "x_axis" do
    before do
      @chart = Chart.new(stub, [stub, stub])
      @chart.stubs(:x_label_y_coordinate).returns (-3)
      @chart.stubs(:x_label_width).returns 10
      @chart.stubs(:line_height).returns 4
      @chart.stubs(:x_axis_dates).returns [2000, 2001, 2002, 2003, 2004]
      @chart.stubs(:x_axis_label_x_coordinates).returns [0, 25, 50, 75, 100]
    end
    it "builds an x axis with the correct number of labels and gridlines" do
      @chart.x_axis.labels.length.must_equal 5
      @chart.x_axis.gridlines.length.must_equal 5
    end
  end
end
