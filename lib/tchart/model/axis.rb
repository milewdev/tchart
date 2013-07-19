module TChart
  class Axis
    attr_reader :ticks
    
    def initialize(ticks)
      @ticks = ticks
    end
    
    def render
      ticks.each { |tick| tick.render }
    end
  end
end
