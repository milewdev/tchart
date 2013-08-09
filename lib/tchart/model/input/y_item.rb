module TChart
  class YItem
    
    attr_reader :name
    attr_reader :bar_style
    attr_reader :date_ranges

    def initialize(name, bar_style, date_ranges)
       @name = name
       @bar_style = bar_style
       @date_ranges = date_ranges
    end
    
    def build(layout, y)
      [ new_y_label(layout, y) ].concat new_bars(layout, y)
    end
    
  private
  
    def new_y_label(layout, y)
      Label.build_ylabel(xy(layout.y_item_x_coordinate, y), layout.y_item_label_width, name)
    end
    
    def new_bars(layout, y)
      date_ranges.map { |date_range| new_bar(*date_range_to_x_range(layout, date_range), y) }
    end
    
    def date_range_to_x_range(layout, date_range)
      x_from = layout.date_to_x_coordinate(date_range.begin)
      x_to = layout.date_to_x_coordinate(date_range.end + 1)     # +1 bumps the time to end-of-day of the end date
      [ x_from, x_to ]
    end
    
    def new_bar(x_from, x_to, y)
      Bar.new(xy(x_from, y), xy(x_to, y), bar_style)
    end
    
  end
end
