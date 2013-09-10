module TChart
  
  #
  # Responsible for storing all command line arguments for use
  # throughout the lifecycle of the application.
  #
  class CommandLineArgs
    
    #
    # File containing chart settings and the items being plotted.
    #
    attr_reader :data_filename
    
    #
    # File to write generated TeX to.
    #
    attr_reader :tex_filename
    
    def initialize(data_filename, tex_filename)
      @data_filename = data_filename
      @tex_filename = tex_filename
    end
    
  end
end
