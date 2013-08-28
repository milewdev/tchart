module TChart
  module CommandLineParser
    
    # TODO: handle tchart - output, tchart input -, and tchart - -
    #       where - means stdin and/or stdout
    def self.parse(argv) # => CommandLineArgs, errors
      data_filename, tex_filename = argv
      errors = validate_args(argv, data_filename, tex_filename)
      [ CommandLineArgs.new(data_filename, tex_filename), errors ]
    end
    
  private
  
    def self.validate_args(argv, data_filename, tex_filename)
      errors = []
      case
      when argv.length != 2
        errors << "Usage: tchart input-data-filename output-tikz-filename"
      when !File.exists?(data_filename)
        errors << "Error: input data file \"#{data_filename}\" not found."
      when !File.file?(data_filename)
        errors << "Error: input data file \"#{data_filename}\" is not a file."
      when same_file?(data_filename, tex_filename)
        errors << "Error: input \"#{data_filename}\" and output \"#{tex_filename}\" refer to the same file."
      end
      errors
    end

    def self.same_file?(filename1, filename2)
      File.expand_path(filename1) == File.expand_path(filename2)
    end

  end
end
