module TChart
  class Chart
    
    attr_reader :settings
    attr_reader :items

    def initialize(settings, items)
      @settings = settings
      @items = items
    end
    
    def x_axis_length
      @settings.chart_width - @settings.y_label_width - @settings.x_label_width
    end
    
    def y_axis_length
      # +1 for top and bottom margins
      (@items.length + 1) * @settings.line_height
    end
    
    def x_axis_labels
      @x_axis_labels ||= XLabelsBuilder.build2(self)
    end
    
    def calc_layout
      @items
        .zip(item_y_coordinates)
        .each { |item, y_coordinate| item.calc_layout(self, y_coordinate) }
    end
    
    # temporary
    alias :y_length :y_axis_length
    alias :x_labels :x_axis_labels
    
  private
    
    def item_y_coordinates
      line_height, num_items = @settings.line_height, @items.length
      (line_height * num_items).step(line_height, -line_height)
    end
    
  end
end
