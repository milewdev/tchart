module TChart
  
  #
  # Responsible for constructing a Chart from a Layout and a collection
  # of items (Separators and YItems).
  #
  class ChartBuilder
    
    def self.build(layout, items) # => Chart
      ChartBuilder.new(layout, items).build
    end
    
    def initialize(layout, items)
      @layout = layout
      @items = items
      @elements = []
    end
    
    def build # => Chart
      build_frame
      build_x_items
      build_y_items
      Chart.new(@elements)
    end
    
  private
  
    def build_frame
      @elements << new_frame_top
      @elements << new_frame_bottom
    end
  
    def new_frame_top # => GridLine
      GridLine.new(xy(0, @layout.y_axis_length), xy(@layout.x_axis_length, @layout.y_axis_length))
    end
  
    def new_frame_bottom # => GridLine
      GridLine.new(xy(0, 0), xy(@layout.x_axis_length, 0))
    end
    
    def build_x_items
      @layout.x_axis_tick_dates.zip(@layout.x_axis_tick_x_coordinates).each do |date, x|
        @elements << new_x_label(date.year, x) 
        @elements << new_x_gridline(x)
      end
    end
    
    def new_x_label(year, x) # => Label
      Label.build_xlabel(xy(x, @layout.x_axis_label_y_coordinate), @layout.x_axis_label_width, year.to_s) 
    end
    
    def new_x_gridline(x) # => GridLine
      GridLine.new(xy(x, 0), xy(x, @layout.y_axis_length))
    end
    
    def build_y_items
      @items.zip(@layout.y_axis_tick_y_coordinates).each do |item, y| 
        @elements.concat item.build(@layout, y)
      end
    end
      
  end
end
