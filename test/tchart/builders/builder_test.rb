require_relative '../../test_helper'

module TChart
  describe Builder, "build_x_items" do
    before do
      @layout = stub
      @layout.stubs(:x_axis_dates).returns [ 2000, 2001 ]
    end

    it "builds a list of x items" do
      x_items = Builder.build_x_items(@layout)
      x_items.length.must_equal 2
      x_items[0].must_equal XItem.new(2000)
      x_items[1].must_equal XItem.new(2001)
    end
  end
end
