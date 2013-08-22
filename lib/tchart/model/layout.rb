module TChart
  class Layout
    
    attr_reader :settings     # Chart settings such as chart width, label widths, etc.
    attr_reader :items        # List of items being plotted on the chart.
    
    def initialize(settings, items)
      @settings = settings
      @items = items
    end
    
    # TODO: rename to x_axis_years?  Or return instances of Date?
    def x_item_dates # => [ year:Numeric, year:Numeric, ... ]
      @x_item_dates ||= calc_x_item_dates
    end
    
    def x_axis_length # => length:Numeric
      @x_axis_length ||= calc_x_axis_length
    end

    def x_item_x_coordinates # => Enumerator of x:Numeric
      @x_item_x_coordinates ||= calc_x_item_x_coordinates
    end
    
    def x_item_y_coordinate # => y:Numeric
      settings.x_item_y_coordinate
    end
    
    def x_axis_label_width # => width:Numeric
      settings.x_axis_label_width
    end
    
    def items_date_range # => earliest:Date..latest:Date
      @items_date_range ||= calc_items_date_range
    end
    
    def y_axis_length # => length:Numeric
      @y_axis_length ||= calc_y_axis_length
    end
    
    # TODO: rename to y_label_x_coordinate
    def y_item_x_coordinate # => x:Numeric
      @y_item_x_coordinate ||= calc_y_item_x_coordinate
    end
  
    def y_item_y_coordinates # => Enumerator of y:Numeric
      @y_item_y_coordinates ||= calc_y_item_y_coordinates
    end
    
    def y_item_label_width # => width:Numeric
      settings.y_item_label_width
    end
    
    def date_range_to_x_coordinates(date_range) # => [ x:Numeric, x:Numeric ]
      x_from = date_to_x_coordinate(date_range.begin)
      x_to = date_to_x_coordinate(date_range.end + 1)   # +1 bumps the time to end-of-day of the end date
      [x_from, x_to]
    end
    
  private

    # TODO: why do some methods return ranges, others return arrays?
    def calc_x_item_dates # => [ year:Numeric, year:Numeric, ... ]
      # try a date for each year in the items date range
      from_year = items_date_range.first.year           # round down to Jan 1st of year
      to_year = items_date_range.last.year + 1          # +1 to round up to Jan 1st of the following year
      return (from_year..to_year).step(1).to_a if to_year - from_year <= 10

      # try a date every five years
      from_year = (from_year / 5.0).floor * 5           # round down to nearest 1/2 decade
      to_year = (to_year / 5.0).ceil * 5                # round up to nearest 1/2 decade
      return (from_year..to_year).step(5).to_a if to_year - from_year <= 50

      # use a date every 10 years
      from_year = (from_year / 10.0).floor * 10         # round down to nearest decade
      to_year = (to_year / 10.0).ceil * 10              # round up to nearest decade
      return (from_year..to_year).step(10).to_a
    end
    
    def calc_x_axis_length # => length:Numeric
      settings.chart_width - settings.y_item_label_width - settings.x_axis_label_width
    end
    
    def calc_x_item_x_coordinates # => Enumerator of x:Numeric
      num_coords = x_item_dates.size
      x_interval = x_axis_length / (num_coords - 1.0)
      (0..x_axis_length).step(x_interval)
    end
      
    # TODO: should return [ earliest, latest ], not a range
    def calc_items_date_range # earliest:Date..latest:Date
      earliest = nil
      latest = nil
      items.each do |item|
        # TODO: this belongs in ChartItem
        item.date_ranges.each do |date_range|
          earliest = date_range.begin if earliest.nil? or date_range.begin < earliest
          latest = date_range.end if latest.nil? or latest < date_range.end
        end
      end
      # TODO: refactor: put this somewhere else
      current_year = Date.today.year
      earliest ||= Date.new(current_year, 1, 1)
      latest ||= Date.new(current_year, 12, 31)
      earliest..latest
    end
    
    # +1 for top and bottom margins, each of which is half the line height
    def calc_y_axis_length # => length:Numeric
      (items.length + 1) * settings.line_height
    end
    
    def calc_y_item_x_coordinate # => x:Numeric
      0 - ((settings.y_item_label_width / 2.0) + (settings.x_axis_label_width / 2.0))
    end
    
    def calc_y_item_y_coordinates # => Enumerator of y:Numeric
      (settings.line_height * items.length).step(settings.line_height, -settings.line_height)
    end
    
    # ratio is: x_coordinate / x_axis_length = ( date - date_range.begin ) / date_range_length
    def date_to_x_coordinate(date) # => x:Numeric
      date_from, date_to = Date.new(x_item_dates.first,1,1), Date.new(x_item_dates.last,1,1)
      date_range_length = date_to.jd - date_from.jd      
      ( x_axis_length * ( date.jd - date_from.jd ) * 1.0 ) / date_range_length 
    end

  end
end
