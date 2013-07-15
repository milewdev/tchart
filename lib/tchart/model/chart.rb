module TChart
  class Chart
    
    attr_reader :settings
    attr_reader :items
    attr_reader :frame

    def initialize(settings, items)
      @settings = settings
      @items = items
      @frame = Frame.new
    end
    
    def x_axis_length
      @settings.chart_width - @settings.y_label_width - @settings.x_label_width
    end
    
    def y_axis_length
      # +1 for top and bottom margins
      (@items.length + 1) * @settings.line_height
    end
    
    def x_axis_labels
      @x_axis_labels ||= XLabelsBuilder.build(self)
    end
    
    def x_axis_date_range
      x_axis_labels.first.date..x_axis_labels.last.date
    end
    
    def calc_layout
      @items
        .zip(item_y_coordinates)
        .each { |item, y_coordinate| item.calc_layout(self, y_coordinate) }
    end
    
    def render
      tex = Tex.new
      tex.echo "\\tikzpicture\n\n"
      @frame.render(tex, self)
      x_axis_labels.each { |label| label.render(tex, self) }
      @items.each { |item| item.render(tex, self) }
      tex.echo "\n\\endtikzpicture\n"
      tex.to_s
    end
    
  private
    
    def item_y_coordinates
      line_height, num_items = @settings.line_height, @items.length
      (line_height * num_items).step(line_height, -line_height)
    end
    
  end
end
