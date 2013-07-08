module TChart
  module XLabelsBuilder
    def self.build(settings, chart_items, x_length, y_length) # => [ XLabel, ... ]
      chart_items_date_range = find_chart_items_date_range(chart_items)
      date_range, date_interval_yr = calc_date_range_and_date_interval(chart_items_date_range)
      number_of_labels = calc_number_of_labels(date_range, date_interval_yr)
      x_interval = calc_x_coordinate_interval(x_length, number_of_labels)
      dates = create_date_range_enumerator(date_range, date_interval_yr)
      x_coordinates = (0..x_length).step(x_interval)
      dates.zip(x_coordinates).map { |date, x_coordinate| XLabel.new(date, x_coordinate, settings.x_label_y_coordinate, y_length) }
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
    
    def self.find_chart_items_date_range(chart_items) # => Date..Date
      begin_date = nil
      end_date = nil
      chart_items.each do |chart_item|
        chart_item.date_ranges.each do |chart_item_date_range|
          begin_date = chart_item_date_range.begin if begin_date.nil? or chart_item_date_range.begin < begin_date
          end_date = chart_item_date_range.end if end_date.nil? or end_date < chart_item_date_range.end
        end
      end
      # TODO: refactor: put this somewhere else
      current_year = Date.today.year
      begin_date ||= Date.new(current_year, 1, 1)
      end_date ||= Date.new(current_year, 12, 31)
      begin_date..end_date
    end
    
    def self.calc_date_range_and_date_interval(chart_items_date_range) # => Date..Date, interval_in_years
      # try a label for each year in the chart_items date range
      from_year = chart_items_date_range.begin.year        # round down to Jan 1st of year
      to_year = chart_items_date_range.end.year + 1        # +1 to round up to Jan 1st of the following year
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
    
    def self.calc_number_of_labels(date_range, date_interval) # => int
      ((date_range.end.year - date_range.begin.year) / date_interval) + 1   # +1 as we are counting fence posts
    end
    
    def self.calc_x_coordinate_interval(x_length, number_of_labels) # => number in same units as x_length
      x_length / ((number_of_labels - 1) * 1.0)       # -1 as we are counting fence segments
    end
  end
end
