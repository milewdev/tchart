require 'date'

module TChart
  module DataReader
    
    def self.read(filename) # => [ settings, items ]
      File.open(filename) do |f| 
        settings, items, errors = DataParser.parse(filename, f) 
        raise_errors(errors) if not errors.empty?
        [ settings, items ]
      end
    end
    
    def self.raise_errors(errors)
      raise TChartError, errors.join("\n")
    end
    
  end
end
