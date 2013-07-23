require_relative '../../test_helper'

module TChart
  describe XAxisBuilder, "build" do
    
    before do
      @settings = stub(chart_width: 130, x_label_width: 10, y_label_width: 20)
      @items = [ stub(date_ranges: [ Date.new(2001,1,1)..Date.new(2001,12,31) ] ) ]
    end
    
    it "builds an x-axis with the correct length" do
      XAxisBuilder.build(@settings, @items).length.must_equal 100
    end
    
    it "builds an x-axis with the correct date range" do
      XAxisBuilder.build(@settings, @items).date_range.must_equal Date.new(2001,1,1)..Date.new(2002,1,1)
    end
    
    it "builds an x-axis with the correct ticks" do
      skip
      XAxisBuilder.build(@settings, @items).ticks.must_equal [ XTick.new(Label.new(), GridLine.new()), XTick.new() ]
    end
    
  end
end
