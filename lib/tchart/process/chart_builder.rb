module TChart
  module ChartBuilder
    
    def self.build(layout, items) # => Chart
      elements = []
      elements.concat build_frame(layout)
      elements.concat build_x_items(layout)
      elements.concat build_y_items(layout, items)
      Chart.new(elements)
    end
    
  private
  
    def self.build_frame(layout) # => [ element, ... ]
      [] << new_frame_top(layout) << new_frame_bottom(layout)
    end
  
    def self.new_frame_top(layout) # => GridLine
      GridLine.new(xy(0, layout.y_axis_length), xy(layout.x_axis_length, layout.y_axis_length))
    end
  
    def self.new_frame_bottom(layout) # => GridLine
      GridLine.new(xy(0, 0), xy(layout.x_axis_length, 0))
    end
    
    def self.build_x_items(layout) # => [ element, ... ]
      layout.x_axis_tick_dates.zip(layout.x_axis_tick_x_coordinates).inject( [] ) do |elements, date_zip_x|
        date, x = date_zip_x
        elements << new_x_label(layout, date.year, x) 
        elements << new_x_gridline(layout, x)
      end
    end
    
    def self.new_x_label(layout, year, x) # => Label
      Label.build_xlabel(xy(x, layout.x_axis_label_y_coordinate), layout.x_axis_label_width, year.to_s) 
    end
    
    def self.new_x_gridline(layout, x) # => GridLine
      GridLine.new(xy(x, 0), xy(x, layout.y_axis_length))
    end
    
    def self.build_y_items(layout, items) # => [ element, ... ]
      items.zip(layout.y_axis_tick_y_coordinates).inject( [] ) do |elements, item_zip_y| 
        item, y = item_zip_y
        elements.concat item.build(layout, y)
      end
    end
      
  end
end
