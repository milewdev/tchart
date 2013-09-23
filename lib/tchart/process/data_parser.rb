module TChart
  
  #
  # Responsible for parsing source data.  Not responsible for 
  # aquiring the source data, e.g. not responsible for reading
  # the source data from an input file.
  #
  class DataParser
    
    #
    # source_name is used in error messages; for example, if the
    # source data was read from a file, then source_name would be
    # the name of that file.
    #
    def self.parse(source_name, source_data) # => [ settings, items, errors ]
      DataParser.new(source_name, source_data).parse
    end
    
    def initialize(source_name, source_data)
      @source_name = source_name
      @source_data = source_data
      @line_number = nil
      @errors = []
      @settings_parser = SettingsParser.new
      @items_parser = ItemsParser.new
    end
    
    def parse # => [ settings, items, errors ]
      non_blank_source_lines.each { |line| parse_line(line) }
      check_for_items if @errors.empty?
      [ @settings_parser.settings, @items_parser.items, @errors ]
    end
    
  private
    
    #
    # Return source data lines that are not empty after
    # comments have been removed.
    #
    def non_blank_source_lines # => Enumerator
      Enumerator.new do |yielder|
        @source_data.each_with_index do |line, index|
          @line_number = index + 1
          line = remove_comments(line).strip
          yielder.yield line if line.length > 0
        end
      end
    end
    
    #
    # "item  # A comment."  => "item  "
    # "# A comment."        => ""
    # "C\#  # A coment."    => "C\#  "
    #
    def remove_comments(line) # => line
      line.sub(/(?<!\\)#.*$/, '')
    end
    
    def parse_line(line)
      if ! @settings_parser.parse?(line)
        @items_parser.parse(line)
      end
    rescue TChartError => e
      save_error "#{@source_name}, #{@line_number}: #{e.message}"
    end

    def check_for_items
      save_error "#{@source_name}: no items found" if @items_parser.items.empty?
    end
    
    def save_error(message)
      @errors << message
    end
    
  end
end
