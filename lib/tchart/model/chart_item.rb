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
    attr_reader :style          # TODO: rename to bar_style
    attr_reader :date_ranges
    attr_reader :y_axis_label
    attr_reader :bars

    def initialize(name, style, date_ranges)
       @name = name
       @style = style
       @date_ranges = date_ranges
    end
    
    def calc_layout(chart, y)
      @y_axis_label = build_label(chart, y)
      @bars = build_bars(chart, y)
    end
    
    def render(tex)
      tex.comment name
      y_axis_label.render(tex)
      bars.each { |bar| bar.render(tex) }
    end
    
  private
  
    def build_label(chart, y)
      # TODO: "ylabel" should be read from somewhere?
      Label.new(chart.y_axis_label_x_coordinate, y, chart.y_label_width, "ylabel", name)
    end
    
    def build_bars(chart, y)
      date_ranges.map do |date_range|
        x_from = chart.date_to_x_coordinate(date_range.begin)
        x_to = chart.date_to_x_coordinate(date_range.end + 1)     # +1 bumps the time to end-of-day of the end date
        Bar.new(Coordinate.new(x_from, y), Coordinate.new(x_to, y), style)
      end
    end
    
  end
end
