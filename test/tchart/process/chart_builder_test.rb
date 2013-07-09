require_relative '../../test_helper'

module TChart
  describe ChartBuilder, "build" do
    
    before do
      @settings = Settings.new
      @settings.chart_width = 120
      @settings.line_height = 10
      @settings.x_label_width = 10
      @settings.y_label_width = 10
      
      @item1 = ChartItem.new( 'item1', 'style', [ Date.new(2001,1,1)..Date.new(2001,12,31) ] )    # TODO: write note that 2000 is a leap year
      @item2 = ChartItem.new( 'item2', 'style', [ Date.new(2002,1,1)..Date.new(2002,12,31) ] )
      @items = [ @item1, @item2 ]
      
      @chart = ChartBuilder.build( @settings, @items )
    end
    
    class BarXCoordinates
      def ==(other)
        [ mid_point, width ] == [ other.mid_point, other.width ]
      end
    end
    
    it "sets the attributes on the returned chart" do
      @chart.chart_items.wont_be_nil
      @chart.x_length.wont_be_nil
      @chart.y_length.wont_be_nil
      @chart.x_labels.wont_be_nil
      @chart.settings.wont_be_nil
    end
    it "calculates the correct x axis length" do
      @chart.x_length.must_equal @settings.chart_width - @settings.y_label_width - @settings.x_label_width
    end
    it "calculates the correct y axis length" do
      @chart.y_length.must_equal @settings.line_height * (@items.length + 1)  # +1 for top and bottom margins
    end
    it "calculates the y coordinates of the the chart items" do
      @item1.y_coordinate.must_equal 20
      @item2.y_coordinate.must_equal 10
    end
    it "calculates the x coordinate ranges of each date range" do
      @item1.bar_x_coordinates.must_equal [ BarXCoordinates.new( 25, 50 ) ]
      @item2.bar_x_coordinates.must_equal [ BarXCoordinates.new( 75, 50 ) ]
    end
  end
end
