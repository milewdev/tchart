module TChart
  class Layout
    
    attr_accessor :x_axis_length              # 
    attr_accessor :x_axis_label_width         # 
    attr_accessor :x_axis_label_y_coordinate  # 
    attr_accessor :x_axis_tick_x_coordinates  # 
    attr_accessor :x_axis_tick_dates          # 
    attr_accessor :y_axis_length              # 
    attr_accessor :y_axis_label_width         # 
    attr_accessor :y_axis_label_x_coordinate  # 
    attr_accessor :y_axis_tick_y_coordinates  # 
    
    def date_range_to_x_coordinates(date_range) # => [ Numeric, Numeric ]
      x_from = date_to_x_coordinate(date_range.begin)
      x_to = date_to_x_coordinate(date_range.end + 1)   # +1 bumps the time to end-of-day of the end date
      [x_from, x_to]
    end
    
  private

    # ratio is: x_coordinate / x_axis_length  =  ( date - date_range.begin ) / date_range_length
    def date_to_x_coordinate(date) # => Numeric
      date_range_begin, date_range_end = @x_axis_tick_dates.first.jd, @x_axis_tick_dates.last.jd
      date_range_length = date_range_end - date_range_begin    
      ( @x_axis_length * ( date.jd - date_range_begin ) * 1.0 ) / date_range_length 
    end

  end
end
