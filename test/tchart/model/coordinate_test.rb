require_relative '../../test_helper'

describe "xy" do
  it "returns a newly allocated coordinate with the passed x,y coordinates" do
    coordinate = xy(4, 2)
    coordinate.must_be_kind_of TChart::Coordinate
    coordinate.x.must_equal 4
    coordinate.y.must_equal 2
  end
end
