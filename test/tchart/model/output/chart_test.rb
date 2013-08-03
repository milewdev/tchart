require_relative '../../../test_helper'

module TChart
  describe Chart, "build" do
    it "invokes 'build' on each item" do
      settings = stub( chart_width: 130, x_label_width: 10, y_label_width: 20, line_height: 10 )
      items = [ stub, stub ]
      chart = Chart.new(settings, items)
      layout = stub( item_y_coordinates: [20, 10] )
      chart.stubs(:layout).returns layout
      items[0].expects(:build).with(chart, 20)
      items[1].expects(:build).with(chart, 10)
      chart.build
    end
  end
end
