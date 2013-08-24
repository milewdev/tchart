module TChart
  class Layout
    
    attr_accessor :items_date_range
    attr_accessor :x_axis_tick_dates    # TODO: rename to x_axis_years?  Or return instances of Date?
    attr_accessor :x_axis_tick_x_coordinates
    attr_accessor :x_axis_length
    attr_accessor :y_axis_length
    attr_accessor :y_axis_label_x_coordinate
    attr_accessor :y_axis_tick_y_coordinates
    attr_accessor :x_axis_label_y_coordinate
    attr_accessor :x_axis_label_width
    attr_accessor :y_axis_label_width
    
    def date_range_to_x_coordinates(date_range) # => [ x:Numeric, x:Numeric ]
      x_from = date_to_x_coordinate(date_range.begin)
      x_to = date_to_x_coordinate(date_range.end + 1)   # +1 bumps the time to end-of-day of the end date
      [x_from, x_to]
    end
    
  private

    # ratio is: x_coordinate / x_axis_length = ( date - date_range.begin ) / date_range_length
    def date_to_x_coordinate(date) # => x:Numeric
      date_from, date_to = Date.new(x_axis_tick_dates.first,1,1), Date.new(x_axis_tick_dates.last,1,1)
      date_range_length = date_to.jd - date_from.jd      
      ( x_axis_length * ( date.jd - date_from.jd ) * 1.0 ) / date_range_length 
    end

  end
end
