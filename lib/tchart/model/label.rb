module TChart
  
  #
  # An x or y axis label on the chart.  X axis labels will be years, e.g. 
  # "2014", "2015", etc., and y axis labels will be descriptions of the
  # items being plotted, e.g. "Ruby", "C", "C++", etc.  Responsible for
  # generating TikZ code to render the label.
  #
  class Label
    
    attr_reader :coord    # Horizontal and vertical mid-point of label location.
    attr_reader :width    # Required for text justification.
    attr_reader :style    # TikZ style, must be defined in encompasing TeX document.
    attr_reader :text
    
    #
    # The difference between an x axis label and a y axis label is the TikZ style;
    # x axis labels are generated with the style "xlabel", y axis labels use 
    # "ylabel".  In the TeX document that embeds the chart, the x axis labels will 
    # usually be styled with centered text, whereas y axis labels will be left
    # justified.
    #
    def self.build_xlabel(coord, width, text) # => Label
      Label.new(coord, width, "xlabel", text)
    end
    
    def self.build_ylabel(coord, width, text) # => Label
      Label.new(coord, width, "ylabel", text)
    end
    
    def initialize(coord, width, style, text)
      @coord = coord
      @width = width
      @style = style
      @text = text
    end
    
    def render(tex)
      tex.label @coord, @width, @style, @text
    end
    
  end
end
