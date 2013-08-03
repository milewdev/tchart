require_relative '../../../test_helper'

module TChart
  describe SeparatorItem, "build" do
    before do
      @layout = stub( x_axis_length: 100 )
      @y = 10
    end
    
    # TODO: move into test_helper.rb
    class GridLine
      def ==(other)
        [ from, to, style ] == [ other.from, other.to, other.style ]
      end
    end
    
    it "returns an array containing a horizontal gridline" do
      elements = SeparatorItem.new.build(@layout, @y)
      elements.length.must_equal 1
      elements[0].must_equal GridLine.new(xy(0,10), xy(100,10), "hgridline")
    end
  end
end
