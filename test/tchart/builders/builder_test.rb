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
  
  describe Builder, "build_x_axis_labels" do
    before do
      @layout = stub()
      @layout.stubs(:x_axis_dates).returns [ 2001, 2002, 2003, 2004, 2005 ]
      @layout.stubs(:x_axis_label_x_coordinates).returns [ 0, 25, 50, 75, 100 ]
      @layout.stubs(:x_label_y_coordinate).returns (-3)
      @layout.stubs(:x_label_width).returns 10
    end

    it "builds x axis labels" do
      labels = Builder.build_x_axis_labels(@layout)
      labels[0].must_equal Label.new(xy(  0, -3), 10, "xlabel", "2001")
      labels[1].must_equal Label.new(xy( 25, -3), 10, "xlabel", "2002")
      labels[2].must_equal Label.new(xy( 50, -3), 10, "xlabel", "2003")
      labels[3].must_equal Label.new(xy( 75, -3), 10, "xlabel", "2004")
      labels[4].must_equal Label.new(xy(100, -3), 10, "xlabel", "2005")
    end
  end
end
