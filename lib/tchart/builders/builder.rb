module TChart
  module Builder
    
    def self.build_x_axis_labels(design)
      design.x_axis_dates
        .zip(design.x_axis_label_x_coordinates)
        .map { |year, x| Label.new(xy(x, design.x_label_y_coordinate), design.x_label_width, "xlabel", year.to_s) }
    end
    
#    def self.build_y_axis_labels(design)
#      Label.build_ylabel(xy(chart.y_axis_label_x_coordinate, y), chart.y_label_width, name)
#    end
  
  end
end
