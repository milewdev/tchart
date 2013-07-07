module TChart
  class CommandLineArgs
    attr_reader :data_filename
    attr_reader :tex_filename
    
    def initialize(data_filename, tex_filename)
      @data_filename = data_filename
      @tex_filename = tex_filename
    end
  end
end
