require_relative '../../test_helper'

module TChart
  describe ChartBuilder, "build" do
    before do
      @layout = stub( 'layout', 
        x_axis_tick_dates: [2001, 2002], 
        x_axis_tick_x_coordinates: [0, 100],  
        x_axis_length: 100, 
        y_axis_length: 50,
        x_axis_label_y_coordinate: -3,
        x_axis_label_width: 10,
        y_axis_tick_y_coordinates: [ 25 ] )
      item = stub ; item.stubs(:build).returns [ Label.build_ylabel(xy(-10, 10), 20, "label"), Bar.new(xy(0, 25), xy(50, 25), "style") ]
      @items = [ item ]
    end
    it "builds a chart" do
      chart = ChartBuilder.build(@layout, @items)
      chart.elements.length.must_equal 8
      chart.elements[0].must_equal GridLine.new(xy(0, 50), xy(100, 50))         # top horizontal frame
      chart.elements[1].must_equal GridLine.new(xy(0, 0), xy(100, 0))           # bottom horizontal frame
      chart.elements[2].must_equal Label.build_xlabel(xy(0, -3), 10, "2001")    # left x-axis label
      chart.elements[3].must_equal GridLine.new(xy(0, 0), xy(0, 50))            # left vertical grid line
      chart.elements[4].must_equal Label.build_xlabel(xy(100, -3), 10, "2002")  # left x-axis label
      chart.elements[5].must_equal GridLine.new(xy(100, 0), xy(100, 50))        # right vertical grid line
      chart.elements[6].must_equal Label.build_ylabel(xy(-10, 10), 20, "label") # item y-axis label
      chart.elements[7].must_equal Bar.new(xy(0, 25), xy(50, 25), "style")      # item bar
    end
  end
end
