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
  # bar_style is the name of a TikZ style that should be defined
  # in the TeX document in which the generated chart is
  # embedded.
  #
  class ChartItem
    
    attr_reader :name
    attr_reader :bar_style
    attr_reader :date_ranges
    attr_reader :y_axis_label
    attr_reader :bars

    def initialize(name, bar_style, date_ranges)
       @name = name
       @bar_style = bar_style
       @date_ranges = date_ranges
    end
    
    def build(chart, y)
      @y_axis_label = build_label(chart, y)
      @bars = build_bars(chart, y)
    end
    
    def render(tex)
      tex.comment name
      y_axis_label.render(tex)
      bars.each { |bar| bar.render(tex) }
      tex.newline
    end
    
  private
  
    def build_label(chart, y)
      Label.build_ylabel(xy(chart.layout.y_axis_label_x_coordinate, y), chart.layout.y_label_width, name)
    end
    
    def build_bars(chart, y)
      date_ranges.map do |date_range|
        x_from = chart.layout.date_to_x_coordinate(date_range.begin)
        x_to = chart.layout.date_to_x_coordinate(date_range.end + 1)     # +1 bumps the time to end-of-day of the end date
        Bar.new(xy(x_from, y), xy(x_to, y), bar_style)
      end
    end
    
  end
end
