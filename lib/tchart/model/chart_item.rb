module TChart
  
  #
  # Represents an item that is plotted on the chart.  Items
  # can have zero or more date ranges, each being represented
  # as a horizontal bar on the chart.  ChartItem captures the
  # name of the item, which is used as the y-axis label, the
  # style of its bars, and zero or date ranges; all of these
  # attributes are read from a data file, for example.  ChartItem 
  # also stores the calculated y-coordinate of the item, and the
  # calculated x coordinates of each of its date ranges.
  #
  # Style is the name of a TikZ style that should be defined
  # in the TeX document in which the generated chart is
  # embedded.
  #
  # SMELL: too many comments above.
  # SMELL: 'ChartItem' sounds too generic ('item' in particular); Plotted?
  # SMELL: need to get rid of mid_point, width calculations in #render.
  # SMELL: the responsibility of converting a date to an x-coordinate belongs in Chart.
  #
  class ChartItem
    
    attr_reader :name
    attr_reader :style
    attr_reader :date_ranges
    attr_accessor :y_coordinate
    attr_accessor :bar_x_coordinates

    def initialize(name, style, date_ranges)
       @name = name
       @style = style
       @date_ranges = date_ranges
    end
    
    def calc_layout(chart, y_coordinate)
      @y_coordinate = y_coordinate
      @bar_x_coordinates = date_ranges.map { |date_range| date_range_to_x_coordinates(chart, date_range) }
    end
    
    def render(tex, chart)
      tex.comment @name
      mid_point, width = chart.settings.y_label_width / -2.0, chart.settings.y_label_width
      tex.label mid_point, @y_coordinate, width, 'ylabel', @name
      @bar_x_coordinates.each { |bar_x_coordinates| tex.bar(bar_x_coordinates.from, bar_x_coordinates.to, @y_coordinate, @style) }
    end
    
  private
    
    def date_range_to_x_coordinates(chart, date_range)
      x_begin = date_to_x_coordinate(chart, date_range.begin)
      x_end = date_to_x_coordinate(chart, date_range.end + 1)     # +1 bumps the time to end-of-day of the end date
      BarXCoordinates.new(x_begin, x_end)
    end
    
    # ratio is: x_coordinate / x_axis_length = ( date - date_range.begin ) / date_range_length
    def date_to_x_coordinate(chart, date)
      date_range = chart.x_axis_date_range
      date_range_length = date_range.end.jd - date_range.begin.jd      
      ( chart.x_axis_length * ( date.jd - date_range.begin.jd ) * 1.0 ) / date_range_length 
    end
    
  end
end
