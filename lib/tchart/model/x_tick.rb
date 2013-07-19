module TChart
  class XTick
    attr_reader :label
    attr_reader :grid_line
    
    def initialize(label, grid_line)
      @label = label
      @grid_line = grid_line
    end
    
    def render
      label.render + grid_line.render
    end
  end
end
