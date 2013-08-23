require 'date'

module TChart
  module DataReader
    
    def self.read(filename) # => [ settings, items, errors ]
      File.open(filename) { |f| DataParser.parse(filename, f) }
    end
    
  end
end
