module TChart
  module Builder
    
    def self.build_x_items(layout)
      layout.x_axis_dates.map { |year| XItem.new(year) }
    end
      
  end
end
