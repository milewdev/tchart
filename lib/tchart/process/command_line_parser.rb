module TChart
  module CommandLineParser
    
    def self.parse(argv) # => CommandLineArgs
      data_filename, tex_filename = argv
      raise_usage if argv.length != 2
      raise_not_found(data_filename) if not File.exists?(data_filename)
      raise_not_a_file(data_filename) if not File.file?(data_filename)
      raise_same_file(data_filename, tex_filename) if same_file?(data_filename, tex_filename)
      CommandLineArgs.new(data_filename, tex_filename)
    end

  private

    def self.same_file?(filename1, filename2)
      File.expand_path(filename1) == File.expand_path(filename2)
    end
    
    def self.raise_usage
      raise TChartError, "Usage: tchart input-data-filename output-tikz-filename"
    end
    
    def self.raise_not_found(data_filename)
      raise TChartError, "Error: input data file \"#{data_filename}\" not found."
    end
    
    def self.raise_not_a_file(data_filename)
      raise TChartError, "Error: input data file \"#{data_filename}\" is not a file."
    end
    
    def self.raise_same_file(data_filename, tex_filename)
      raise TChartError, "Error: input \"#{data_filename}\" and output \"#{tex_filename}\" refer to the same file."
    end
    
  end
end
