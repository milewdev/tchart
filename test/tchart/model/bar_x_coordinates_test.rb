require_relative '../../test_helper'

module TChart
  describe BarXCoordinates, "mid_point" do
    it "returns the mid-point between the start and end coordinates of the bar" do
      BarXCoordinates.new(10, 110).mid_point.must_equal 60
    end
  end
  
  describe BarXCoordinates, "width" do
    it "returns the width of the bar" do
      BarXCoordinates.new(0, 100).width.must_equal 100
    end
  end
end
