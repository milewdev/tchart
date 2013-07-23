require_relative '../../test_helper'

module TChart
  describe ChartItem, "calc_layout" do
    before do
      @chart = stub(y_label_width: 20)
      @chart.stubs(:x_axis_date_range).returns( Date.new(2001,1,1)..Date.new(2003,1,1) )
      @chart.stubs(:date_to_x_coordinate).with(Date.new(2001,1,1)).returns(0)
      @chart.stubs(:date_to_x_coordinate).with(Date.new(2002,1,1)).returns(50)
      @chart.stubs(:y_axis_label_x_coordinate).returns(-10)
      @item = ChartItem.new("name", "bar_style", [ Date.new(2001,1,1)..Date.new(2001,12,31) ])
    end
  
    class Label
      def ==(other)
        [ x, y, width, style, text ] == [ other.x, other.y, other.width, other.style, other.text ]
      end
    end
    
    class Bar
      def ==(other)
        [ from.x, from.y, to.x, to.y, style ] == [ other.from.x, other.from.y, other.to.x, other.to.y, style ]
      end
    end
    
    it "creates a label and a list of bars" do
      @item.calc_layout(@chart, 10)
      @item.y_axis_label.must_equal Label.new(-10,10,20,"ylabel","name")
      @item.bars.must_equal [ Bar.new(Coordinate.new(0,10),Coordinate.new(50,10),"bar_style") ]
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
