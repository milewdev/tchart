module TChart
  module Builder
    
    def self.build_x_items(layout)
      layout.x_axis_dates.map { |year| XItem.new(year) }
    end
    
    def self.build_x_axis_labels(layout)
      layout.x_axis_dates
        .zip(layout.x_axis_label_x_coordinates)
        .map { |year, x| Label.new(xy(x, layout.x_label_y_coordinate), layout.x_label_width, "xlabel", year.to_s) }
    end
  
  end
end
