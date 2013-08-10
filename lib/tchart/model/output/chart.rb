#
# SMELL: #render is ugly; still not happy about Tex and, specifically, Tex#to_s.
#
module TChart
  class Chart
    
    attr_reader :elements

    def initialize(elements)
      @elements = elements
    end
    
    def render
      tex = TeXBuilder.new
      tex.echo "\\tikzpicture\n\n"
      elements.each { |element| element.render(tex) }
      tex.echo "\n\\endtikzpicture\n"
      tex.to_s
    end
    
  end
end
