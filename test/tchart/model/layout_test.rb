require_relative '../../test_helper'

module TChart
  describe Layout, "items_date_range" do
    before do
      @settings = stub
      @this_year = Date.today.year
    end
    it "returns a range from the earliest chart item start date to the latest chart item end date" do
      item1 = stub( :date_ranges => [Date.new(2000, 11, 1)..Date.new(2005, 3, 21)] )
      item2 = stub( :date_ranges => [Date.new(2002, 4, 17)..Date.new(2008, 3, 30)] )
      Layout.new(@settings, [item1, item2]).items_date_range.must_equal Date.new(2000, 11, 1)..Date.new(2008, 3, 30)
    end
    it "returns 1st January to 31st December when chart items is empty" do
      Layout.new(@settings, []).items_date_range.must_equal Date.new(@this_year,1,1)..Date.new(@this_year,12,31)
    end
    it "returns 1st January to 31st December when none of the chart items have date ranges" do
      item1 = stub( :date_ranges => [] )
      item2 = stub( :date_ranges => [] )
      Layout.new(@settings, [item1, item2]).items_date_range.must_equal Date.new(@this_year,1,1)..Date.new(@this_year,12,31)
    end
  end

  describe Layout, "x_item_dates" do
    before do
      settings = stub
      @layout = Layout.new(settings, [])
    end
    it "returns the correct dates when the items date range is less than 10 years" do
      @layout.stubs(:items_date_range).returns Date.new(2000,3,17)..Date.new(2004,10,4)
      @layout.x_item_dates.must_equal (2000..2005).step(1).to_a
    end
    it "returns the correct dates when the items date range is 10 years" do
      @layout.stubs(:items_date_range).returns Date.new(2000,3,17)..Date.new(2009,10,4)
      @layout.x_item_dates.must_equal (2000..2010).step(1).to_a
    end
    it "returns the correct dates when the items date range is 11 years" do
      @layout.stubs(:items_date_range).returns Date.new(2000,3,17)..Date.new(2010,10,4)
      @layout.x_item_dates.must_equal (2000..2015).step(5).to_a
    end
    it "returns the correct dates when the items date range is less than 50 years" do
      @layout.stubs(:items_date_range).returns Date.new(2000,3,17)..Date.new(2044,10,4)
      @layout.x_item_dates.must_equal (2000..2045).step(5).to_a
    end
    it "returns the correct dates when the items date range is 50 years" do
      @layout.stubs(:items_date_range).returns Date.new(2000,3,17)..Date.new(2049,10,4)
      @layout.x_item_dates.must_equal (2000..2050).step(5).to_a
    end
    it "returns the correct dates when the items date range is less than 60 years" do
      @layout.stubs(:items_date_range).returns Date.new(2000,3,17)..Date.new(2054,10,4)
      @layout.x_item_dates.must_equal (2000..2060).step(10).to_a
    end
    it "returns the correct dates when the items date range is 60 years" do
      @layout.stubs(:items_date_range).returns Date.new(2000,3,17)..Date.new(2059,10,4)
      @layout.x_item_dates.must_equal (2000..2060).step(10).to_a
    end
  end
  
  describe Layout, "x_item_x_coordinates" do
    before do
      @settings = stub
      @layout = Layout.new(@settings, [])
    end
    it "returns an array of x coordinates" do
      @layout.stubs(:x_item_dates).returns (2000..2005).step(1)
      @layout.stubs(:x_axis_length).returns 100
      @layout.x_item_x_coordinates.to_a.must_equal (0..100).step(20.0).to_a
    end
  end

  describe Layout, "x_axis_length" do
    before do
      @settings = stub(chart_width: 130, x_item_label_width: 10, y_item_label_width: 20)
      items = stub
      @layout = Layout.new(@settings, items)
    end
    it "returns the correct length" do
      @layout.x_axis_length.must_equal @settings.chart_width - @settings.x_item_label_width - @settings.y_item_label_width
    end
  end

  describe Layout, "y_axis_length" do
    before do
      @settings = stub(line_height: 10)
      @items = [ stub, stub, stub ]
      @layout = Layout.new(@settings, @items)
    end
    it "returns the correct length" do
      @layout.y_axis_length.must_equal @settings.line_height * (@items.length + 1)
    end
  end

  describe Layout, "y_item_x_coordinate" do
    before do
      @settings = stub(x_item_label_width: 10, y_item_label_width: 20)
      items = stub
      @layout = Layout.new(@settings, items)
    end
    it "returns the correct value" do
      @layout.y_item_x_coordinate.must_equal 0 - ((@settings.y_item_label_width / 2.0) + (@settings.x_item_label_width / 2.0))
    end
  end
  
  describe Layout, "y_item_y_coordinates" do
    before do
      settings = stub(line_height: 10)
      items = [ stub, stub, stub ]
      @layout = Layout.new(settings, items)
    end
    it "returns the y coordinates of all items" do
      @layout.y_item_y_coordinates.to_a.must_equal [30, 20, 10]
    end
  end
  
  describe Layout, "date_range_to_x_coordinates" do
    before do
      settings = stub( chart_width: 130, x_item_label_width: 10, y_item_label_width: 20, line_height: 10 )
      items = stub
      @layout = Layout.new(settings, items)
      @layout.stubs(:x_item_dates).returns (2001..2002).step(1).to_a
      @layout.stubs(:x_axis_length).returns 100
    end
    it "converts a date range to its equivalent x_coordinate range on the chart" do
      @layout.date_range_to_x_coordinates(Date.new(2001,1,1)..Date.new(2001,12,31)).must_equal [0.0, 100.0]
    end
  end
end
