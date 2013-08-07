module TChart
  class Layout
    
    attr_reader :settings
    attr_reader :items
    
    def initialize(settings, items)
      @settings = settings
      @items = items
    end
    
    # TODO: rename to x_axis_years?  Or return instances of Date?
    def x_item_dates
      @x_item_dates ||= calc_x_item_dates
    end
    
    def x_axis_length
      @x_axis_length ||= calc_x_axis_length
    end

    def x_item_x_coordinates
      @x_item_x_coordinates ||= calc_x_item_x_coordinates
    end
    
    def x_item_y_coordinate
      settings.x_item_y_coordinate
    end
    
    def x_item_label_width
      settings.x_item_label_width
    end
    
    def y_items_date_range
      @y_items_date_range ||= calc_y_items_date_range
    end
    
    def y_axis_length
      @y_axis_length ||= calc_y_axis_length
    end
    
    def y_item_x_coordinate
      @y_item_x_coordinate ||= calc_y_item_x_coordinate
    end
  
    def y_item_y_coordinates
      @y_item_y_coordinates ||= calc_y_item_y_coordinates
    end
    
    def y_item_label_width
      settings.y_item_label_width
    end
    
    # ratio is: x_coordinate / x_axis_length = ( date - date_range.begin ) / date_range_length
    def date_to_x_coordinate(date)
      date_from, date_to = Date.new(x_item_dates.first,1,1), Date.new(x_item_dates.last,1,1)
      date_range_length = date_to.jd - date_from.jd      
      ( x_axis_length * ( date.jd - date_from.jd ) * 1.0 ) / date_range_length 
    end
    
  private

    def calc_x_item_dates
      # try a date for each year in the items date range
      from_year = y_items_date_range.first.year         # round down to Jan 1st of year
      to_year = y_items_date_range.last.year + 1        # +1 to round up to Jan 1st of the following year
      return (from_year..to_year).step(1).to_a if to_year - from_year <= 10

      # try a date every five years
      from_year = (from_year / 5.0).floor * 5         # round down to nearest 1/2 decade
      to_year = (to_year / 5.0).ceil * 5              # round up to nearest 1/2 decade
      return (from_year..to_year).step(5).to_a if to_year - from_year <= 50

      # use a date every 10 years
      from_year = (from_year / 10.0).floor * 10       # round down to nearest decade
      to_year = (to_year / 10.0).ceil * 10            # round up to nearest decade
      return (from_year..to_year).step(10).to_a
    end
    
    def calc_x_item_x_coordinates
      num_coords = x_item_dates.size
      x_interval = x_axis_length / (num_coords - 1.0)
      (0..x_axis_length).step(x_interval)
    end
    
    def calc_x_axis_length
      settings.chart_width - settings.y_item_label_width - settings.x_item_label_width
    end
      
    def calc_y_items_date_range
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
    
    # -1 for top and bottom margins, each of which is half the line height
    def calc_y_axis_length
      (items.length - 1) * settings.line_height
    end
    
    def calc_y_item_x_coordinate
      -settings.y_item_label_width / 2.0
    end
    
    def calc_y_item_y_coordinates
      (settings.line_height * (items.length - 1)).step(0, -settings.line_height)
    end

  end
end
