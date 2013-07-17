require_relative '../../test_helper'

module TChart
  describe ChartItem, "calc_layout" do
    
    class Label
      def ==(other)
        [ x, y, width, style, text ] == [ other.x, other.y, other.width, other.style, other.text ]
      end
    end
    
    class Bar
      def ==(other)
        [ x_from, x_to, y, style ] == [ other.x_from, other.x_to, y, style ]
      end
    end
    
    it "creates a label and a list of bars" do
      chart = stub(y_label_width: 20)
      chart.stubs(:x_axis_date_range).returns( Date.new(2001,1,1)..Date.new(2003,1,1) )
      chart.stubs(:date_to_x_coordinate).with(Date.new(2001,1,1)).returns(0)
      chart.stubs(:date_to_x_coordinate).with(Date.new(2002,1,1)).returns(50)
      chart.stubs(:y_axis_label_x_coordinate).returns(-10)
      item = ChartItem.new("name", "bar_style", [ Date.new(2001,1,1)..Date.new(2001,12,31) ])
      item.calc_layout(chart, 10)
      item.y_axis_label.must_equal Label.new(-10,10,20,"ylabel","name")
      item.bars.must_equal [ Bar.new(0,50,10,"bar_style") ]
    end
  end
    
  describe ChartItem, "render" do
    it "generates TeX code to render and item" do
      chart = stub(y_label_width: 20)
      chart.stubs(:y_axis_label_x_coordinate).returns(-10)
      item = ChartItem.new("name", "bar_style", [ Date.new(2001,1,1)..Date.new(2001,12,31) ])
      item.stubs(:y_coordinate).returns(30)
      item.stubs(:y_axis_label).returns(Label.new(-10,30,20,"ylabel","name"))
      item.stubs(:bars).returns([Bar.new(0,50,30,"bar_style")])
      tex = Tex.new
      item.render(tex, chart)
      tex.to_s.must_equal <<-EOS.unindent
        % name
        \\node [ylabel, text width = 20.00mm] at (-10.00mm, 30.00mm) {name};
        \\node [bar_style] at (25.00mm, 30.00mm) [minimum width = 50.00mm] {};
      EOS
    end
  end
end
