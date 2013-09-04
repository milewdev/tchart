module TChart
  class Chart
    
    attr_reader :elements     # Each must respond to #render.

    def initialize(elements)
      @elements = elements
    end
    
    def render # => String
      tex = TeXBuilder.new
      tex.echo "\\tikzpicture\n"
      @elements.each { |element| element.render(tex) }
      tex.echo "\\endtikzpicture\n"
      tex.to_s
    end
    
  end
end
