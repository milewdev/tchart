module TChart
  
  #
  # The plots of zero or more date ranges.  Includes bars representing the
  # date ranges, x and y axes lines, gridlines, and labels.  Has overall
  # responsibility for generating all of the TikZ code to render the chart.
  #
  class Chart
    
    attr_reader :elements     # Labels, gridlines and bars that make up the chart.

    def initialize(elements)
      @elements = elements
    end
    
    def render # => String
      tex = TeXBuilder.new
      tex.begin_chart
      @elements.each { |element| element.render(tex) }
      tex.end_chart
      tex.to_s
    end
    
  end
end
