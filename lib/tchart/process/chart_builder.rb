module TChart
  class ChartBuilder
    
    def self.build(layout, items)
      ChartBuilder.new(layout, items).build
    end
    
    attr_reader :layout
    attr_reader :items
    attr_reader :elements

    def initialize(layout, items)
      @items = items
      @layout = layout
      @elements = []
    end
  
    def build
      build_x_items
      build_y_items
      build_frame
      Chart.new(elements)
    end
    
  private
    
    def build_x_items
      layout.x_item_dates.zip(layout.x_item_x_coordinates).each do |year, x| 
        @elements.push Label.build_xlabel(xy(x, layout.x_item_y_coordinate), layout.x_item_label_width, year.to_s) 
        @elements.push GridLine.new(xy(x, 0), xy(x, layout.y_axis_length))
      end
    end
    
    def build_y_items
      items.zip(layout.y_item_y_coordinates).each do |item, y| 
        @elements += item.build(@layout, y)
      end
    end
    
    def build_frame
      elements.push new_frame_top
      elements.push new_frame_bottom
    end
    
    def new_frame_top
      GridLine.new(xy(0, layout.y_axis_length), xy(layout.x_axis_length, layout.y_axis_length))
    end
    
    def new_frame_bottom
      GridLine.new(xy(0, 0), xy(layout.x_axis_length, 0))
    end
      
  end
end
