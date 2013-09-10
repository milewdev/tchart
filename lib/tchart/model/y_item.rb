module TChart
  
  #
  # The input data file specifies settings, data lines, and separators.  A
  # data line consists of a description, which becomes a y axis label, zero
  # or more date ranges to be plotted on the chart as horizontal bars, and
  # a TikZ style for the bars.  YItem is reponsible for capturing all of
  # that information and for building the label and bar elements.
  #
  class YItem
    
    #
    # Used for the content of the y-label.
    #
    attr_reader :description
    
    #
    # TikZ style for the bars.  The style must be defined in the TeX document
    # that embeds the chart.
    #
    attr_reader :bar_style
    
    #
    # Each item can have zero or more date ranges, which will appear as bars 
    # on the chart.
    #
    attr_reader :date_ranges

    def initialize(description, bar_style, date_ranges)
       @description = description
       @bar_style = bar_style
       @date_ranges = date_ranges
    end
    
    #
    # Build the elements that represent the item on the chart 
    # (i.e. builds a y axis label and zero or more bars).
    #
    def build(layout, y) # => [ Label, Bar, Bar, ... ]
      [ new_y_label(layout, y) ].concat new_bars(layout, y)
    end
    
  private
  
    def new_y_label(layout, y) # => Label
      Label.build_ylabel(xy(layout.y_axis_label_x_coordinate, y), layout.y_axis_label_width, @description)
    end
    
    def new_bars(layout, y) # => [ Bar, Bar, ... ]
      @date_ranges.map do |date_range| 
        x_from, x_to = layout.date_range_to_x_coordinates(date_range)
        new_bar(x_from, x_to, y)
      end
    end
    
    def new_bar(x_from, x_to, y) # => Bar
      Bar.new(xy(x_from, y), xy(x_to, y), @bar_style)
    end
    
  end
end
