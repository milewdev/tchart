module TChart
  class Builder
    
    def self.build(layout, items)
      Builder.new(layout, items).build
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
      x_items = layout.x_item_dates.map { |year| XItem.new(year) }
      x_items
        .zip(layout.x_item_x_coordinates)
        .each { |item, x| @elements += item.build(@layout, x) }
    end
    
    def build_y_items
      items
        .zip(layout.y_item_y_coordinates)
        .each { |item, y| @elements += item.build(@layout, y) }
    end
    
    def build_frame
      elements.push(build_frame_top)
      elements.push(build_frame_bottom)
    end
    
    def build_frame_top
      GridLine.new(xy(0, layout.y_axis_length), xy(layout.x_axis_length, layout.y_axis_length))
    end
    
    def build_frame_bottom
      GridLine.new(xy(0, 0), xy(layout.x_axis_length, 0))
    end
      
  end
end
