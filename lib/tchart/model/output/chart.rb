#
# SMELL: #render is ugly; still not happy about Tex and, specifically, Tex#to_s.
# SMELL: the use of '@attribute' rather than 'attribute' seemed to highlight that attribute 
#        is an attribute of self.  But, look at '@frame' vs. 'x_axis_labels' in #render; 
#        this is inconsistent access.
# SMELL: the standalone #calc_layout; who is responsible for calling it?  What was wrong
#        with #build again?
#
module TChart
  class Chart
    
    attr_reader :x_items
    attr_reader :y_items
    attr_reader :layout     # TODO: retire

    def initialize(settings, x_items, y_items)
      @x_items = x_items
      @y_items = y_items
      @layout = Layout.new(settings, y_items)
    end
    
    def frame
      @frame ||= Frame.new(@layout)
    end
    
    def build
      # TODO: see if there is a way of collecting the arrays without using 'elements'
      @elements = []
      x_items
        .zip(layout.x_axis_label_x_coordinates)
        .each { |item, x| @elements += item.build(layout, x) }
      y_items
        .zip(layout.item_y_coordinates)
        .each { |item, y| @elements += item.build(layout, y) }
      @elements
    end
    
    def render
      tex = Tex.new
      tex.echo "\\tikzpicture\n\n"
      frame.render(tex)
      @elements.each { |element| element.render(tex) }
      tex.echo "\n\\endtikzpicture\n"
      tex.to_s
    end
    
  end
end
