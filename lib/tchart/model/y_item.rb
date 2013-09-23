module TChart
  
  #
  # The input data file specifies settings, data lines, and separators.  A
  # data line consists of a description, which becomes a y axis label, zero
  # or more date ranges to be plotted on the chart as horizontal bars, and
  # a TikZ style for the bars.  YItem is reponsible for capturing all of
  # that information and for building the label and bar elements.
  #
  class YItem
    
    attr_reader :description    # Used for the y-label.
    attr_reader :bar_style      # TikZ style, must be defined in encompasing TeX document.
    attr_reader :date_ranges    # Can be >= 0; drawn as bars on the chart.

    def initialize(description, bar_style, date_ranges)
       @description = description
       @bar_style = bar_style
       @date_ranges = date_ranges
    end
    
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
