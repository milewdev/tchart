module TChart
  class DataParser
    def self.parse(source_name, source_data) # => settings, chart_items, errors
      DataParser.new.parse(source_name, source_data)
    end
  
    def initialize
      @source_name = nil
      @line_number = nil
      @settings = Settings.new
      @chart_items = []
      @errors = []
    end
    
    def parse(source_name, source_data) # => settings, chart_items, errors
      @source_name = source_name
      lines_of_interest_in(source_data).each { |line| parse_line(line) }
      check_for_chart_items
      [ @settings, @chart_items, @errors ]
    end
    
    def lines_of_interest_in(source_data) # => Enumerator
      Enumerator.new do |yielder|
        source_data.each_with_index do |line, index|
          @line_number = index + 1
          line = remove_escapes(remove_comments(line)).strip
          yielder.yield line if line.length > 0
        end
      end
    end
    
    def remove_comments(line) # => line
      line.sub(/(?<!\\)#.*$/, '')
    end
    
    def remove_escapes(line) # => line
      line.sub(/\\(.)/, '\1')
    end
    
    def parse_line(line)
      case
      when parse_setting(line)
      when parse_chart_item(line)
      end
    rescue TChartError => e
      save_error e.message
    end
    
    def check_for_chart_items
      save_error "no chart items found" if @errors.length == 0 && @chart_items.length == 0
    end
    
    def save_error(message)
      @errors << "#{@source_name}, #{@line_number}: #{message}"
    end
    
    
    #
    # Settings
    #
    
    def parse_setting(line) # => success or failed
      return false if not match = match_setting(line)
      name, value = match[1].strip, match[2].strip
      raise_unknown_setting(name) if not @settings.has_setting?(name)
      save_setting(name, value)
      true
    end
    
    def match_setting(line) # => MatchData
      /^([^=]+)=(.+)$/.match(line)
    end
    
    def save_setting(name, value)
      if @settings.send(name).kind_of? Numeric
        raise_not_a_float(value) if not float?(value)
        value = value.to_f
      end
      @settings.send("#{name}=", value)
    end
    
    def float?(value)
      value =~ /^(\+|-)?\d+(\.\d*)?$/
    end
    
    def raise_unknown_setting(name)
      raise TChartError, "unknown setting \"#{name}\"; expecting one of: #{@settings.setting_names.join(', ')}"
    end
    
    def raise_not_a_float(value)
      raise TChartError, "\"#{value}\" is not a number; expecting e.g. 123 or 123.45"
    end
    
    
    #
    # Chart items
    #
    
    def parse_chart_item(line) # => success or failed
      name, style, *date_range_strings = extract_non_blank_fields(line)
      date_ranges = parse_date_ranges(date_range_strings)
      check_for_overlaps(date_ranges)
      save_chart_item ChartItem.new(name, style, date_ranges)
      true
    end
    
    def extract_non_blank_fields(line) # => [ String, ... ]
      line
        .split(/\t/)
        .map { |field| field.strip }
        .select { |field| field.length > 0 }
    end
    
    def parse_date_ranges(date_range_strings) # => [ Date..Date, ... ]
      date_range_strings.map { |date_range_string| parse_date_range(date_range_string) }
    end
    
    def parse_date_range(date_range_string) # => Date..Date
      y1, m1, d1, y2, m2, d2 = fill_in_missing_date_elements( * match_date_range(date_range_string) )
      date_begin = build_date(y1.to_i, m1.to_i, d1.to_i)
      date_end = build_date(y2.to_i, m2.to_i, d2.to_i)
      raise_date_range_reversed(date_begin, date_end) if date_end < date_begin
      date_begin..date_end
    end
    
    def build_date(year, month, day) # => Date
      Date.new(year, month, day)
    rescue ArgumentError => e
      raise_invalid_date(year, month, day, e.message)
    end
    
    # Matches d, d-d, or d - d, where d can be: y, y.m, or y.m.d
    # Examples: 2000, 2000-2001, 2000-2001.8, 2000.4.17 - 2001
    def match_date_range(date_range_string) # => y1, m1, d1, y2, m2, d2
      m = /^(\d+)(\.(\d+)(\.(\d+))?)?(\s*-\s*(\d+)(\.(\d+)(\.(\d+))?)?)?$/.match(date_range_string)
      raise_invalid_date_range(date_range_string) if not m
      [ m[1], m[3], m[5], m[7], m[9], m[11] ]
    end
    
    def fill_in_missing_date_elements(y1, m1, d1, y2, m2, d2) # => y1, m1, d1, y2, m2, d2
      [ y1, m1 || 1, d1 || 1, y2 || y1, m2 || 12, d2 || -1 ]
    end
    
    def check_for_overlaps(date_ranges)
      first, *rest = date_ranges
      return if rest.empty?
      rest.each { |range| raise_date_ranges_overlap(first, range) if overlap?(first, range) }
      check_for_overlaps(rest)
    end
    
    def overlap?(range1, range2)
      range1.include?(range2.first) or range2.include?(range1.first)
    end
    
    def save_chart_item(chart_item)
      @chart_items << chart_item
    end
    
    # date to string
    def d2s(date) # => String
      date.strftime('%Y.%-m.%-d')
    end
    
    # date range to string
    def dr2s(date_range) # => String
      "#{d2s(date_range.begin)}-#{d2s(date_range.end)}"
    end
    
    def raise_invalid_date(year, month, day, message)
      raise TChartError, "#{year}.#{month}.#{day}: #{message}"
    end
    
    def raise_invalid_date_range(date_range_as_string)
      raise TChartError, "bad date range \"#{date_range_as_string}\"; expecting 2000.4.17-2001.7.21, or 2000.4-2001, etc."
    end
    
    def raise_date_range_reversed(date_begin, date_end)
      raise TChartError, "date range end #{d2s(date_end)} before start #{d2s(date_begin)}"
    end
    
    def raise_date_ranges_overlap(range1, range2)
      raise TChartError, "date range #{dr2s(range1)} overlaps #{dr2s(range2)}"
    end
  end
end
