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
    
    def render(chart)
      RendererFactory.chart_item_renderer.render(chart, self)
    end
  end
  
end
