module TChart
  
  #
  # Responsible for reading source data from an input file
  # and parsing it.
  #
  module DataReader
    
    def self.read(filename) # => [ settings, items, errors ]
      File.open(filename) { |f| DataParser.parse(filename, f) }
    end
    
  end
end
