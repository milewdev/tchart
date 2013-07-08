module TChart
  class XLabel
    attr_reader :date
    attr_reader :x_coordinate
    
    def initialize(date, x_coordinate)
      @date = date
      @x_coordinate = x_coordinate
    end
  end
end
