module TChart
  
  #
  # Stores various chart metrics such as the length of the axes, the width 
  # of the axes labels, the coordinates of the axes labels, and so on.  All
  # metrics are unitless, although they should all be in the same unit.
  # Responsible for converting a date range to its equivalent start and end
  # coordinates on the chart.
  #
  class Layout
    
    #
    # The length of the x axis from the leftmost to the rightmost label.
    #
    attr_accessor :x_axis_length
    
    #
    # The amount of horizontal space to allocate for each x axis label.
    # Used to determine the width of the margins to the left and right of
    # the x axis, and also passed to TikZ/TeX.
    #
    attr_accessor :x_axis_label_width
    
    #
    # The distance of the mid point of the x axis labels from the x axis.
    #
    attr_accessor :x_axis_label_y_coordinate
    
    #
    # The x coordinates of the x axis labels and associated vertical
    # grid lines.
    #
    attr_accessor :x_axis_tick_x_coordinates
    
    #
    # The dates to be used for the x axis labels.
    #
    attr_accessor :x_axis_tick_dates
    
    #
    # The length of the y axis from the topmost to the bottommost item.
    #
    attr_accessor :y_axis_length
    
    #
    # The width of the y axis labels.  Used to calculate the amount of 
    # horizontal space to leave for the labels, and also passed in the
    # generated TikX code.
    #
    attr_accessor :y_axis_label_width
    
    #
    # The distance of the mid point of the y axis labels to the left 
    # of the y axis.
    #
    attr_accessor :y_axis_label_x_coordinate
    
    #
    # The y coordinates of the y axis labels and their associated bars.
    #
    attr_accessor :y_axis_tick_y_coordinates
    
    #
    # Convert a date range, e.g. Date.new(2000,1,1)..Date.new(2002,10,3), to
    # its equivalent start and end coordinates on the chart.
    #
    def date_range_to_x_coordinates(date_range) # => [ Numeric, Numeric ]
      x_from = date_to_x_coordinate(date_range.begin)
      x_to = date_to_x_coordinate(date_range.end + 1)   # +1 bumps the time to end-of-day of the end date
      [x_from, x_to]
    end
    
  private

    #
    # ratio is: x_coordinate / x_axis_length  =  ( date - date_range.begin ) / date_range_length
    #
    def date_to_x_coordinate(date) # => Numeric
      date_range_begin, date_range_end = @x_axis_tick_dates.first.jd, @x_axis_tick_dates.last.jd
      date_range_length = date_range_end - date_range_begin    
      ( @x_axis_length * ( date.jd - date_range_begin ) * 1.0 ) / date_range_length 
    end

  end
end
