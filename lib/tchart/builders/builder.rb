module TChart
  module Builder
    
    def self.add_horizontal_frame(y_items)
      [ SeparatorItem.new ] + y_items + [ SeparatorItem.new ]
    end
    
    def self.build_x_items(layout)
      layout.x_item_dates.map { |year| XItem.new(year) }
    end
      
  end
end
