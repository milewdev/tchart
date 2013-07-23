module TChart
  module XAxisBuilder
    
    def self.build(settings, items)
      date_range, date_interval_yr = calc_date_range(items)
      length = calc_length(settings)
      ticks = build_ticks(date_range, date_interval_yr)
      x_axis = XAxis.new(date_range, length, ticks)
    end
    
  private
    
    def self.calc_date_range(items)
      items_date_range = find_items_date_range(items)
      calc_date_range_and_date_interval(items_date_range)
    end
    
    def self.calc_length(settings)
      settings.chart_width - settings.y_label_width - settings.x_label_width
    end
    
    def self.find_items_date_range(items)
      from, to = nil, nil
      items.each do |chart_item|
        # TODO: make this logic the responsibility of ChartItem
        chart_item.date_ranges.each do |date_range|
          from = date_range.begin if from.nil? or date_range.begin < from
          to = date_range.end if to.nil? or to < date_range.end
        end
      end
      # TODO: refactor: put this somewhere else
      current_year = Date.today.year
      from ||= Date.new(current_year, 1, 1)
      to ||= Date.new(current_year, 12, 31)
      from..to
    end
    
    def self.calc_date_range_and_date_interval(items_date_range)
      # try a label for each year in the items date range
      from_year = items_date_range.begin.year        # round down to Jan 1st of year
      to_year = items_date_range.end.year + 1        # +1 to round up to Jan 1st of the following year
      return Date.new(from_year, 1, 1)..Date.new(to_year, 1, 1), 1 if to_year - from_year <= 10

      # try a label every five years
      from_year = (from_year / 5.0).floor * 5         # round down to nearest 1/2 decade
      to_year = (to_year / 5.0).ceil * 5              # round up to nearest 1/2 decade
      return Date.new(from_year, 1, 1)..Date.new(to_year, 1, 1), 5 if to_year - from_year <= 50

      # use a label every 10 years
      from_year = (from_year / 10.0).floor * 10       # round down to nearest decade
      to_year = (to_year / 10.0).ceil * 10            # round up to nearest decade
      return Date.new(from_year, 1, 1)..Date.new(to_year, 1, 1), 10
    end
    
    def self.build_ticks(date_range, date_interval_yr, x_axis_length, x_interval)
      dates = create_date_range_enumerator(date_range, date_interval_yr)
      x_coordinates = (0..chart.x_axis_length).step(x_interval)
    end
    
    def self.create_date_range_enumerator(date_range, date_interval_yr) # => Enumerator
      Enumerator.new do |yielder|
        date = date_range.begin
        while date <= date_range.end
          yielder.yield date
          date = date.next_year(date_interval_yr)
        end
      end
    end
    
  end
end
