require_relative '../../test_helper'

module TChart
  describe ChartItem, "calc_layout" do
    
    class BarXCoordinates
      def ==(other)
        [ from, to ] == [ other.from, other.to ]
      end
    end
    
    it "calculates the x coordinate ranges of each date range" do
      chart = stub( x_axis_length: 100 )
      chart.stubs(:x_axis_date_range).returns( Date.new(2001,1,1)..Date.new(2003,1,1) )
      chart.stubs(:date_to_x_coordinate).with(Date.new(2001,1,1)).returns(0)
      chart.stubs(:date_to_x_coordinate).with(Date.new(2002,1,1)).returns(50)
      item = ChartItem.new( "name", "style", [ Date.new(2001,1,1)..Date.new(2001,12,31) ] )
      y_coordinate = 10
      item.calc_layout(chart, y_coordinate)
      item.bar_x_coordinates.must_equal [ BarXCoordinates.new(0, 50) ]
    end
  end
  
  describe ChartItem, "render" do
    it "generates TeX code to render an item" do
      settings = stub( y_label_width: 20 )
      chart = stub(settings: settings, x_axis_length: 100)
      chart.stubs(:x_axis_date_range).returns(Date.new(2001,1,1)..Date.new(2003,1,1))
      item = ChartItem.new("item", "style", [ Date.new(2001,1,1)..Date.new(2001,12,31) ])
      item.stubs(:y_coordinate).returns(30)
      item.stubs(:bar_x_coordinates).returns([ BarXCoordinates.new(0,50) ])
      tex = Tex.new
      item.render(tex, chart)
      tex.to_s.must_equal <<-EOS.unindent
        % item
        \\node [ylabel, text width = 20.00mm] at (-10.00mm, 30.00mm) {item};
        \\node [style] at (25.00mm, 30.00mm) [minimum width = 50.00mm] {};
      EOS
    end
  end
end
