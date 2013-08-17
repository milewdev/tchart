module TChart
  class YItem
    
    # TODO: change 'name' to 'label'?
    attr_reader :name             # Used for the content of the y-label.
    attr_reader :bar_style        # TikZ style for the bars (must be defined in TeX document).
    attr_reader :date_ranges      # Each item can have zero or more date ranges, which will appear as bars on the chart.

    def initialize(name, bar_style, date_ranges)
       @name = name
       @bar_style = bar_style
       @date_ranges = date_ranges
    end
    
    def build(layout, y) # => [ Label, Bar, Bar, ... ]
      [ new_y_label(layout, y) ].concat new_bars(layout, y)
    end
    
  private
  
    def new_y_label(layout, y) # => Label
      Label.build_ylabel(xy(layout.y_item_x_coordinate, y), layout.y_item_label_width, name)
    end
    
    def new_bars(layout, y) # => [ Bar, Bar, ... ]
      date_ranges.map do |date_range| 
        x_from, x_to = layout.date_range_to_x_coordinates(date_range)
        new_bar(x_from, x_to, y)
      end
    end
    
    def new_bar(x_from, x_to, y) # => Bar
      Bar.new(xy(x_from, y), xy(x_to, y), bar_style)
    end
    
  end
end
