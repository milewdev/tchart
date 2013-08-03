require_relative '../../../test_helper'

module TChart
  describe ChartItem, "build" do
    before do
      layout = stub
      layout.stubs(:x_axis_date_range).returns( Date.new(2001,1,1)..Date.new(2003,1,1) )
      layout.stubs(:y_axis_label_x_coordinate).returns(-10)
      layout.stubs(:y_label_width).returns(20)
      @chart = stub
      @chart.stubs(:layout).returns layout
      @chart.stubs(:date_to_x_coordinate).with(Date.new(2001,1,1)).returns(0)
      @chart.stubs(:date_to_x_coordinate).with(Date.new(2002,1,1)).returns(50)
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
    
    it "creates a label and a list of bars" do
      @item.build(@chart, 10)
      @item.y_axis_label.must_equal Label.build_ylabel(xy(-10,10), 20, "name")
      @item.bars.must_equal [ Bar.new(xy(0,10), xy(50,10), "bar_style") ]
    end
  end
    
  describe ChartItem, "render" do
    before do
      @tex = Tex.new
      @item = ChartItem.new("name", "bar_style", [ Date.new(2001,1,1)..Date.new(2001,12,31) ])
    end
    
    it "generates TeX code to render an item" do
      label = stub ; label.expects(:render).once
      bar = stub ; bar.expects(:render).once
      @item.stubs(:y_axis_label).returns(label)
      @item.stubs(:bars).returns([bar])
      @item.render(@tex)
    end
  end
end
