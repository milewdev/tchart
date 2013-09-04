module TChart
  class ItemsParser
    
    attr_reader :items
    
    def initialize
      @items = []
    end
    
    def parse(line)
      description, style, *date_range_strings = extract_fields(line)
      raise_description_missing if description.nil?
      raise_style_missing if style.nil? && date_range_strings.length > 0
      if description.start_with?("---")
        parse_separator
      else
        parse_y_item(description, style, date_range_strings)
      end
    end
    
  private
    
    def parse_y_item(description, style, date_range_strings)
      date_ranges = parse_date_ranges(date_range_strings)
      check_for_overlaps(date_ranges)
      save_item YItem.new(description, style, date_ranges)
    end
    
    def parse_separator
      save_item Separator.new
    end
    
    def save_item(item)
      @items << item
    end
    
    def extract_fields(line) # => [ String, ... ]
      line                                              # 'a|b\|c|d | | e | \n'
        .sub( /(\s|\|)+$/, '' )                         # 'a|b\|c|d | | e'
        .split( /(?<!\\)\|/ )                           # [ 'a', 'b\|c', 'd ', ' ', ' e' ]
        .map { |field| remove_escapes(field) }          # [ 'a', 'b|c', 'd', ' ', 'e' ]
        .map { |field| field.strip }                    # [ 'a', 'b|c', 'd', '', 'e' ]
        .map { |field| field.empty? ? nil : field }     # [ 'a', 'b|c', 'd', nil, 'e' ]
    end
    
    def remove_escapes(line) # => line
      line.gsub(/\\(.)/, '\1')
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
      [ y1, m1 || 1, d1 || 1, 
        y2 || y1, m2 || 12, d2 || -1 ]
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
    
    def raise_description_missing
      raise TChartError, "description is missing"
    end

    def raise_style_missing
      raise TChartError, "style is missing"
    end
    
    def raise_invalid_date(year, month, day, message)
      raise TChartError, "#{year}.#{month}.#{day}: #{message}"
    end
    
    def raise_invalid_date_range(date_range_as_string)
      raise TChartError, "bad date range \"#{date_range_as_string}\"; expecting 2000.4.17-2001.7.21 | 2002.4-2003, etc."
    end
    
    def raise_date_range_reversed(date_begin, date_end)
      raise TChartError, "date range end #{d2s(date_end)} before start #{d2s(date_begin)}"
    end
    
    def raise_date_ranges_overlap(range1, range2)
      raise TChartError, "date range #{dr2s(range1)} overlaps #{dr2s(range2)}"
    end
    
    # d2s = date to string
    def d2s(date) # => String
      date.strftime('%Y.%-m.%-d')
    end
    
    # dr2s = date range to string
    def dr2s(date_range) # => String
      "#{d2s(date_range.begin)}-#{d2s(date_range.end)}"
    end
    
  end
end
