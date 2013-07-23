#
# SMELL: #render is ugly; still not happy about Tex and, specifically, Tex#to_s.
# SMELL: the use of '@attribute' rather than 'attribute' seemed to highlight that attribute 
#        is an attribute of self.  But, look at '@frame' vs. 'x_axis_labels' in #render; 
#        this is inconsistent access.
# SMELL: the standalone #calc_layout; who is responsible for calling it?  What was wrong
#        with #build again?
#

require 'forwardable'

module TChart
  class Chart
    
    extend Forwardable
    def_delegators :@settings, :chart_width, :x_label_width, :x_label_y_coordinate, :line_height, :y_label_width
    
    attr_reader :settings
    attr_reader :items

    def initialize(settings, items)
      @settings = settings
      @items = items
    end
    
    def x_axis_length
      chart_width - y_label_width - x_label_width
    end
    
    def y_axis_length
      # +1 for top and bottom margins
      (items.length + 1) * line_height
    end
    
    def y_axis_label_x_coordinate
      -y_label_width / 2.0
    end
    
    def x_axis_labels
      @x_axis_labels ||= XLabelsBuilder.build(self)
    end
    
    def frame
      @frame ||= Frame.new(self)
    end
    
    def calc_layout
      items
        .zip(item_y_coordinates)
        .each { |item, y_coordinate| item.calc_layout(self, y_coordinate) }
    end
    
    # ratio is: x_coordinate / x_axis_length = ( date - date_range.begin ) / date_range_length
    def date_to_x_coordinate(date)
      date_from, date_to = x_axis_labels.first.date, x_axis_labels.last.date
      date_range_length = date_to.jd - date_from.jd      
      ( x_axis_length * ( date.jd - date_from.jd ) * 1.0 ) / date_range_length 
    end
    
    def render
      tex = Tex.new
      tex.echo "\\tikzpicture\n\n"
      frame.render(tex)
      x_axis_labels.each { |label| label.render(tex, self) }
      items.each { |item| item.render(tex) }
      tex.echo "\n\\endtikzpicture\n"
      tex.to_s
    end
    
  private
    
    def item_y_coordinates
      (line_height * items.length).step(line_height, -line_height)
    end
    
  end
end
