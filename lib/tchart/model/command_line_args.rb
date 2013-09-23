module TChart
  
  #
  # Responsible for storing all command line arguments for use
  # throughout the lifecycle of the application.
  #
  class CommandLineArgs
    
    attr_reader :data_filename    # input file
    attr_reader :tex_filename     # output file
    
    def initialize(data_filename, tex_filename)
      @data_filename = data_filename
      @tex_filename = tex_filename
    end
    
  end
end
