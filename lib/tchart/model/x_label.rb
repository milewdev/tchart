module TChart
  class XLabel
    attr_reader :date
    attr_reader :x_coordinate
    attr_reader :y_coordinate
    attr_reader :y_length
    
    def initialize(date, x_coordinate, y_coordinate, y_length)
      @date = date
      @x_coordinate = x_coordinate
      @y_coordinate = y_coordinate
      @y_length = y_length
    end
  end
end
