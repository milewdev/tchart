module TChart
  class XAxis < Axis
    
    attr_reader :date_range
    
    def initialize(date_range, length, ticks)
      super(length, ticks)
      @date_range = date_range
    end
    
  end
end
