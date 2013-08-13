module TChart
  class CommandLineArgs
    
    attr_reader :data_filename      # File containing settings and items being plotted.
    attr_reader :tex_filename       # File to write generated TeX to.
    
    def initialize(data_filename, tex_filename)
      @data_filename = data_filename
      @tex_filename = tex_filename
    end
    
  end
end
