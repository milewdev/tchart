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
  # Items whose name starts with three dashes, ---, appear on
  # the chart as horizontal separator lines, used to create
  # vertical sections on the chart.  One could create another
  # object to represent such items and the use something like
  # double dispatch in the TeXGenerator module to correctly
  # render the items, but that would be overkill for the size
  # of this application.
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
    
    def render(chart)
      RendererFactory.chart_item_renderer.render(chart, self)
    end
    
  private
    
    # Bar coordinates for tikz are expressed as the x coordinate of the mid-point of the bar
    # and the width of the bar, rather than the start and end x coordinates of the bar.
    def date_range_to_x_coordinates(chart, date_range)
      x_begin = date_to_x_coordinate(chart, date_range.begin)
      x_end = date_to_x_coordinate(chart, date_range.end + 1)     # +1 bumps the time to midnight
      x_width = x_end - x_begin
      x_mid_point = x_begin + ( x_width / 2.0 )
      BarXCoordinates.new( x_mid_point, x_width )
    end
    
    # x_coordinate / x_axis_length = ( date - date_range.begin ) / date_range_length
    def date_to_x_coordinate(chart, date)
      # TODO: use lazy evaluation?  Perhaps too complex.
      # TODO: calculating the date range is not our responsibility
      date_range_length = chart.x_labels.last.date.jd - chart.x_labels.first.date.jd   
      ( chart.x_axis_length * ( date.jd - chart.x_labels.first.date.jd ) * 1.0 ) / date_range_length 
    end
    
  end
  
end
