require_relative '../../test_helper'

module TChart
  describe TeXGenerator, "generate" do
    before do
      settings = stub( :x_label_y_coordinate => -10, :x_label_width => 10, :y_label_width => 20, :line_height => 10 )
      label1 = XLabel.new(Date.new(2000,1,1), 0)
      label2 = XLabel.new(Date.new(2001,1,1), 100)
      labels = [ label1, label2 ]
      item1 = ChartItem.new("item1", "style1", [])
      item1.y_coordinate = 20
      item1.bar_x_coordinates = [ BarXCoordinates.new(25, 50) ]
      item2 = ChartItem.new("item2", "style2", [])
      item2.y_coordinate = 10
      item2.bar_x_coordinates = [ BarXCoordinates.new( 75, 50 ) ]
      items = [ item1, item2 ]
      @chart = stub( :settings => settings, :x_axis_length => 100, :y_axis_length => 30, :x_labels => labels, :items => items )
    end
    it "generates a TeX chart" do
      TeXGenerator.generate(@chart).must_equal <<-EOS.unindent
        \\tikzpicture

            % horizontal bottom frame
            \\draw [draw = black!5] (0.00mm, 0.00mm) -- (100.00mm, 0.00mm);

            % horizontal top frame
            \\draw [draw = black!5] (0.00mm, 30.00mm) -- (100.00mm, 30.00mm);

            % 2000
            \\draw (0.00mm, -10.00mm) node [xlabel] {2000};
            \\draw [draw = black!5] (0.00mm, 0.00mm) -- (0.00mm, 30.00mm);

            % 2001
            \\draw (100.00mm, -10.00mm) node [xlabel] {2001};
            \\draw [draw = black!5] (100.00mm, 0.00mm) -- (100.00mm, 30.00mm);

            % item1
            \\node [ylabel, text width = 20.00mm] at (-10.00mm, 20.00mm) {item1};
            \\node [style1] at (25.00mm, 20.00mm) [minimum width = 50.00mm] {};

            % item2
            \\node [ylabel, text width = 20.00mm] at (-10.00mm, 10.00mm) {item2};
            \\node [style2] at (75.00mm, 10.00mm) [minimum width = 50.00mm] {};

        \\endtikzpicture
      EOS
    end
  end
  
  describe TeXGenerator, "escape_tex_special_chars" do
    it "escapes TeX special characters" do
      skip
      chart = stub()
      TeXGenerator.new(chart).escape_tex_special_chars("#&").must_equal '\#\&'
    end
  end
end
