require_relative '../../test_helper'

module TChart  
  describe XLabelsBuilder, "build" do
    before do
      x_axis_length = 100
      items = [ stub(:date_ranges => [ Date.new(2000,3,17)..Date.new(2003,10,4) ]) ]
      @x_labels = XLabelsBuilder.build(items, x_axis_length)
    end
    it "builds the correct number of labels" do
      @x_labels.length.must_equal 5
    end
    it "builds labels with the correct text" do
      @x_labels[0].date.must_equal Date.new(2000,1,1)
      @x_labels[1].date.must_equal Date.new(2001,1,1)
      @x_labels[2].date.must_equal Date.new(2002,1,1)
      @x_labels[3].date.must_equal Date.new(2003,1,1)
      @x_labels[4].date.must_equal Date.new(2004,1,1)
    end
    it "builds labels with the correct x-coordinate" do
      @x_labels[0].x_coordinate.must_equal 0
      @x_labels[1].x_coordinate.must_equal 25
      @x_labels[2].x_coordinate.must_equal 50
      @x_labels[3].x_coordinate.must_equal 75
      @x_labels[4].x_coordinate.must_equal 100
    end
  end

  describe XLabelsBuilder, "find_items_date_range" do
    it "returns a range from the earliest chart item start date to the latest chart item end date" do
      chart_item1 = stub( :date_ranges => [Date.new(2000, 11, 1)..Date.new(2005, 3, 21)] )
      chart_item2 = stub( :date_ranges => [Date.new(2002, 4, 17)..Date.new(2008, 3, 30)] )
      items_date_range = XLabelsBuilder.find_items_date_range( [chart_item1, chart_item2] )
      items_date_range.must_equal Date.new(2000, 11, 1)..Date.new(2008, 3, 30)
    end
    it "returns 1st January to 31st December when chart items is empty" do
      items_date_range = XLabelsBuilder.find_items_date_range( [] )
      this_year = Date.today.year
      items_date_range.must_equal Date.new(this_year,1,1)..Date.new(this_year,12,31)
    end
    it "returns 1st January to 31st December when none of the chart items have date ranges" do
      chart_item1 = stub( :date_ranges => [] )
      chart_item2 = stub( :date_ranges => [] )
      items_date_range = XLabelsBuilder.find_items_date_range( [chart_item1, chart_item2] )
      this_year = Date.today.year
      items_date_range.must_equal Date.new(this_year,1,1)..Date.new(this_year,12,31)
    end
  end

  describe XLabelsBuilder, "calc_date_range_and_date_interval" do
    it "calculates the correct range and interval when the chart items date range is less than 10 years" do
      items_date_range = Date.new(2000,3,17)..Date.new(2004,10,4)
      date_range, date_interval = XLabelsBuilder.calc_date_range_and_date_interval(items_date_range)
      date_range.must_equal Date.new(2000,1,1)..Date.new(2005,1,1)
      date_interval.must_equal 1
    end
    it "calculates the correct range and interval when the chart items date range is 10 years" do
      items_date_range = Date.new(2000,3,17)..Date.new(2009,10,4)
      date_range, date_interval = XLabelsBuilder.calc_date_range_and_date_interval(items_date_range)
      date_range.must_equal Date.new(2000,1,1)..Date.new(2010,1,1)
      date_interval.must_equal 1
    end
    it "calculates the correct range and interval when the chart items date range is 11 years" do
      items_date_range = Date.new(2000,3,17)..Date.new(2010,10,4)
      date_range, date_interval = XLabelsBuilder.calc_date_range_and_date_interval(items_date_range)
      date_range.must_equal Date.new(2000,1,1)..Date.new(2015,1,1)
      date_interval.must_equal 5
    end
    it "calculates the correct range and interval when the chart items date range is less than 50 years" do
      items_date_range = Date.new(2000,3,17)..Date.new(2044,10,4)
      date_range, date_interval = XLabelsBuilder.calc_date_range_and_date_interval(items_date_range)
      date_range.must_equal Date.new(2000,1,1)..Date.new(2045,1,1)
      date_interval.must_equal 5
    end
    it "calculates the correct range and interval when the chart items date range is 50 years" do
      items_date_range = Date.new(2000,3,17)..Date.new(2049,10,4)
      date_range, date_interval = XLabelsBuilder.calc_date_range_and_date_interval(items_date_range)
      date_range.must_equal Date.new(2000,1,1)..Date.new(2050,1,1)
      date_interval.must_equal 5
    end
    it "calculates the correct range and interval when the chart items date range is less than 60 years" do
      items_date_range = Date.new(2000,3,17)..Date.new(2054,10,4)
      date_range, date_interval = XLabelsBuilder.calc_date_range_and_date_interval(items_date_range)
      date_range.must_equal Date.new(2000,1,1)..Date.new(2060,1,1)
      date_interval.must_equal 10
    end
    it "calculates the correct range and interval when the chart items date range is 60 years" do
      items_date_range = Date.new(2000,3,17)..Date.new(2059,10,4)
      date_range, date_interval = XLabelsBuilder.calc_date_range_and_date_interval(items_date_range)
      date_range.must_equal Date.new(2000,1,1)..Date.new(2060,1,1)
      date_interval.must_equal 10
    end
  end
  
  describe XLabelsBuilder, "calc_number_of_labels" do
    it "calculates the correct number of labels" do
      date_range = Date.new(2000,1,1)..Date.new(2010,1,1)
      date_interval = 5
      number_of_labels = XLabelsBuilder.calc_number_of_labels(date_range, date_interval)
      number_of_labels.must_equal 3
    end
  end
  
  describe XLabelsBuilder, "calc_x_coordinate_interval" do
    it "calculates the correct x-coordinate interval between labels" do
      x_axis_length = 100
      number_of_labels = 11
      x_coordinate_interval = XLabelsBuilder.calc_x_coordinate_interval(x_axis_length, number_of_labels)
      x_coordinate_interval.must_equal 10
    end
  end
end
