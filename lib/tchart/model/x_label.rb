module TChart
  class XLabel
    attr_reader :date
    attr_reader :x_coordinate
    attr_reader :y_coordinate
    
    def initialize(date, x_coordinate, y_coordinate)
      @date = date
      @x_coordinate = x_coordinate
      @y_coordinate = y_coordinate
    end
  end
end
