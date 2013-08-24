require_relative '../../test_helper'

module TChart
  describe Layout, "date_range_to_x_coordinates" do
    before do
      @layout = Layout.new
      @layout.stubs(:x_axis_tick_dates).returns (2001..2002).step(1).to_a
      @layout.stubs(:x_axis_length).returns 100
    end
    it "converts a date range to its equivalent x_coordinate range on the chart" do
      @layout.date_range_to_x_coordinates(Date.new(2001,1,1)..Date.new(2001,12,31)).must_equal [0.0, 100.0]
    end
  end
end
