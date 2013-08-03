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
    
    attr_reader :items
    attr_reader :layout     # TODO: retire

    def initialize(settings, items)
      @settings = settings  # TODO: retire
      @items = items
      @layout = Layout.new(settings, items)
    end
    
    def frame
      @frame ||= Frame.new(@layout)
    end
    
    def build
      items
        .zip(layout.item_y_coordinates)
        .each { |item, y_coordinate| item.build(layout, y_coordinate) }
    end
    
    def render
      tex = Tex.new
      tex.echo "\\tikzpicture\n\n"
      frame.render(tex)
      render_x_axis_labels(tex)
      render_vertical_gridlines(tex)
      items.each { |item| item.render(tex) }
      tex.echo "\n\\endtikzpicture\n"
      tex.to_s
    end
    
  private
    
    def x_axis_labels
      Builder.build_x_axis_labels(layout)
    end
    
    def vertical_gridlines
      @vertical_gridlines ||= layout.x_axis_label_x_coordinates.map { |x| GridLine.build_vgridline(xy(x, 0), xy(x, layout.y_axis_length)) }
    end
    
    def render_x_axis_labels(tex)
      tex.comment "x-axis labels"
      x_axis_labels.each { |label| label.render(tex) }
      tex.newline
    end
    
    def render_vertical_gridlines(tex)
      tex.comment "vertical grid lines"
      vertical_gridlines.each { |gridline| gridline.render(tex) }
      tex.newline
    end
    
  end
end
