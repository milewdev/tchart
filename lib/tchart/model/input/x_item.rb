module TChart
  class XItem
    
    attr_reader :year
    attr_reader :x
    
    def initialize(year)
      @year = year
    end
    
    def build(layout, x)
      [ build_label(layout, x), build_gridline(layout, x) ]
    end
    
  private
    
    def build_label(layout, x)
      Label.new(xy(x, layout.x_item_y_coordinate), layout.x_item_label_width, "xlabel", year.to_s)
    end
    
    def build_gridline(layout, x)
      GridLine.new(xy(x, 0), xy(x, layout.y_axis_length))
    end
    
  end
end
