module TChart
  class Chart
    attr_reader :chart_items
    attr_reader :x_length
    attr_reader :y_length
    attr_reader :x_labels
    attr_reader :settings
    
    def initialize(chart_items, x_length, y_length, x_labels, settings)
      @chart_items = chart_items
      @x_length = x_length
      @y_length = y_length
      @x_labels = x_labels
      @settings = settings
    end
  end
end
