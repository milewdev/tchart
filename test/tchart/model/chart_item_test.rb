require_relative '../../test_helper'

module TChart
  describe ChartItem, "calc_layout" do
    
    class BarXCoordinates
      def ==(other)
        [ mid_point, width ] == [ other.mid_point, other.width ]
      end
    end
    
    it "calculates the x coordinate ranges of each date range" do
      label1 = stub( date: Date.new(2001,1,1) )
      label2 = stub( date: Date.new(2003,1,1) )
      chart = stub( x_axis_length: 100, x_axis_labels: [ label1, label2 ] )
      item = ChartItem.new( "name", "style", [ Date.new(2001,1,1)..Date.new(2001,12,31) ] )
      y_coordinate = 10
      item.calc_layout(chart, y_coordinate)
      item.bar_x_coordinates.must_equal [ BarXCoordinates.new(25, 50) ]
    end
  end
  
  describe ChartItem, "render" do
    before do
      @chart_item = ChartItem.new("name", "style", [ Date.new(2000,1,1)..Date.new(2000,12,31) ])
      @chart = stub
      @renderer = stub
    end
    it "invokes RendererFactory#chart_item_renderer" do
      @renderer.stubs(:render).with(@chart, @chart_item)
      RendererFactory.expects(:chart_item_renderer).returns(@renderer)
      @chart_item.render(@chart)
    end
    it "invokes ChartItemRenderer#render" do
      @renderer.expects(:render).with(@chart, @chart_item)
      RendererFactory.stubs(:chart_item_renderer).returns(@renderer)
      @chart_item.render(@chart)
    end
  end
end
