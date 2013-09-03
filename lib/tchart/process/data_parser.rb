module TChart
  class DataParser
    
    def self.parse(source_name, source_data) # => [ settings, items, errors ]
      DataParser.new(source_name, source_data).parse
    end
    
  # private
  
    def initialize(source_name, source_data)
      @source_name = source_name
      @source_data = source_data
      @line_number = nil
      @errors = []
      @settings_parser = SettingsParser.new
      @items_parser = ItemsParser.new
    end
    
    def parse # => [ settings, items, errors ]
      source_lines_of_interest.each { |line| parse_line(line) }
      # TODO: move somewhere else? maybe Main?
      check_for_items
      [ @settings_parser.settings, @items_parser.items, @errors ]
    end
    
  private
    
    def source_lines_of_interest # => Enumerator of line
      Enumerator.new do |yielder|
        @source_data.each_with_index do |line, index|
          @line_number = index + 1
          line = remove_comments(line).strip
          yielder.yield line if line.length > 0
        end
      end
    end
    
    def remove_comments(line) # => line
      line.sub(/(?<!\\)#.*$/, '')
    end
    
    def parse_line(line)
      @settings_parser.parse(line) || @items_parser.parse(line)
    rescue TChartError => e
      @errors << "#{@source_name}, #{@line_number}: #{e.message}"
    end

    # TODO: move somewhere else
    def check_for_items
      @errors << "#{@source_name}: no items found" if @errors.length == 0 && @items_parser.items.length == 0
    end
    
  end
end
