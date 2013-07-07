module TChart
  class ChartBuilder
    def self.build(settings, chart_items)
      ChartBuilder.new(settings, chart_items).build
    end
    
    def initialize(settings, chart_items)
      @settings = settings
      @chart_items = chart_items
    end
    
    def build
      @x_length = calc_x_length     # TODO: rename to x_axis_length, y_axis_length
      @y_length = calc_y_length
      @x_labels = DateLabelsBuilder.build(@chart_items, @x_length)    # TODO: rename to x_axis_labels?
      @y_coordinates = calc_chart_item_y_coordinates
      assign_chart_item_y_coordinates
      calc_chart_items_x_coordinate_ranges
      Chart.new(@chart_items, @x_length, @y_length, @x_labels)
    end

    def calc_x_length
      # subtract 1/2 the x label width for the beginning and 1/2 for the end
      @settings.chart_width - @settings.y_label_width - @settings.x_label_width    
    end
    
    def calc_y_length
      # +1 for top and bottom margins
      (@chart_items.length + 1) * @settings.line_height
    end
    
    def calc_chart_item_y_coordinates
      line_height = @settings.line_height
      (line_height * @chart_items.length).step(line_height, -line_height)
    end
    
    def assign_chart_item_y_coordinates
      @chart_items
        .zip(@y_coordinates)
        .each { |item, y_coordinate| item.y_coordinate = y_coordinate }
    end
    
    def calc_chart_items_x_coordinate_ranges    # TODO: rename to calc_bar_x_coordinates?
      @chart_items
        .each { |item| item.bar_x_coordinates = calc_chart_item_x_coordinate_ranges(item) }
    end
    
    def calc_chart_item_x_coordinate_ranges(chart_item)
      chart_item.date_ranges
        .map { |date_range| date_range_to_x_coordinates(date_range) }
    end
    
    # Bar coordinates for tikz are expressed as the x coordinate of the mid-point of the bar
    # and the width of the bar, rather than the start and end x coordinates of the bar.
    def date_range_to_x_coordinates(date_range) # => [ x_coordinate, length ]
      x_begin = date_to_x_coordinate(date_range.begin)
      x_end = date_to_x_coordinate(date_range.end + 1)     # +1 bumps the time to midnight
      x_width = x_end - x_begin
      x_mid_point = x_begin + ( x_width / 2.0 )
      BarXCoordinates.new( x_mid_point, x_width )
    end
    
    # x_coordinate / x_length = ( date - date_range.begin ) / date_range_length
    def date_to_x_coordinate(date) # => x_coordinate
      date_range_length = @x_labels.last.date.jd - @x_labels.first.date.jd              # TODO: use lazy evaluation?  Perhaps too complex.
      ( @x_length * ( date.jd - @x_labels.first.date.jd ) * 1.0 ) / date_range_length 
    end
  end
end
