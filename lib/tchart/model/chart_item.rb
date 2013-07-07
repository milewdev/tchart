module TChart
  class ChartItem
    attr_reader :name
    attr_reader :style
    attr_reader :date_ranges
    attr_accessor :y_coordinate
    attr_accessor :bar_x_coordinates

    def initialize(name, style, date_ranges)
       @name = name
       @style = style
       @date_ranges = date_ranges
    end
  end
end
