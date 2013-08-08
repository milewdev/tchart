module TChart
  module Builder
    
    def self.build_chart(settings, items)
      layout = Layout.new(settings, items)
      elements = build(layout, items)
      Chart.new(elements)
    end
    
  private
    
    def self.build(layout, items)
      x_items = build_x_items(layout)

      elements = []
      x_items
        .zip(layout.x_item_x_coordinates)
        .each { |item, x| elements += item.build(layout, x) }
      items
        .zip(layout.y_item_y_coordinates)
        .each { |item, y| elements += item.build(layout, y) }
        
      elements.push(GridLine.new(xy(0, layout.y_axis_length), xy(layout.x_axis_length, layout.y_axis_length)))
      elements.push(GridLine.new(xy(0, 0), xy(layout.x_axis_length, 0)))
      
      elements
    end
    
    def self.build_x_items(layout)
      layout.x_item_dates.map { |year| XItem.new(year) }
    end
      
  end
end
