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
  #
  class ChartItem
    
    attr_reader :name
    attr_reader :style
    attr_reader :date_ranges
    attr_reader :y_coordinate
    attr_reader :bars

    def initialize(name, style, date_ranges)
       @name = name
       @style = style
       @date_ranges = date_ranges
    end
    
    def calc_layout(chart, y_coordinate)
      @y_coordinate = y_coordinate
      @bars = build_bars(chart, y_coordinate)
    end
    
    def render(tex, chart)
      tex.comment name
      tex.label chart.y_axis_label_x_coordinate, y_coordinate, chart.y_label_width, 'ylabel', name
      bars.each { |bar| tex.bar(bar.x_from, bar.x_to, bar.y, bar.style) }
    end
    
  private
    
    def build_bars(chart, y_mid)
      date_ranges.map do |date_range|
        x_from = chart.date_to_x_coordinate(date_range.begin)
        x_to = chart.date_to_x_coordinate(date_range.end + 1)     # +1 bumps the time to end-of-day of the end date
        Bar.new(x_from, x_to, y_mid, style)
      end
    end
    
  end
end
