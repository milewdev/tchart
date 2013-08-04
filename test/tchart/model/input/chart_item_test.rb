require_relative '../../../test_helper'

module TChart
  describe ChartItem, "build" do
    before do
      @layout = stub
      @layout.stubs(:x_axis_date_range).returns( Date.new(2001,1,1)..Date.new(2003,1,1) )
      @layout.stubs(:y_axis_label_x_coordinate).returns(-10)
      @layout.stubs(:y_label_width).returns(20)
      @layout.stubs(:date_to_x_coordinate).with(Date.new(2001,1,1)).returns(0)
      @layout.stubs(:date_to_x_coordinate).with(Date.new(2002,1,1)).returns(50)
      @item = ChartItem.new("name", "bar_style", [ Date.new(2001,1,1)..Date.new(2001,12,31) ])
    end
    
    class Coordinate
      def ==(other)
        [ x, y ] == [ other.x, other.y ]
      end
    end
  
    class Label
      def ==(other)
        [ coord, width, style, text ] == [ other.coord, other.width, other.style, other.text ]
      end
    end
    
    class Bar
      def ==(other)
        [ from, to, style ] == [ other.from, other.to, style ]
      end
    end
    
    it "returns an array containing a label and bars" do
      elements = @item.build(@layout, 10)
      elements.length.must_equal 2
      elements
    end
  end
end
