module TChart
  module Builder
    
    def self.build_frame(y_items)
      [ YSeparator.new ] + y_items + [ YSeparator.new ]
    end
    
    def self.build_x_items(layout)
      layout.x_item_dates.map { |year| XItem.new(year) }
    end
      
  end
end
