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
      Layout.new(settings, items).x_axis_length
    end
    
    def y_axis_length
      Layout.new(settings, items).y_axis_length
    end
    
    def y_axis_label_x_coordinate
      Layout.new(settings, items).y_axis_label_x_coordinate
    end
    
    def x_axis_dates
      Layout.new(settings, items).x_axis_dates
    end
    
    def x_axis_label_x_coordinates
      Layout.new(settings, items).x_axis_label_x_coordinates
    end
    
    def items_date_range
      Layout.new(items).items_date_range
    end
    
    def frame
      @frame ||= Frame.new(self)
    end
    
    def calc_layout
      items
        .zip(Layout.new(settings, items).item_y_coordinates)
        .each { |item, y_coordinate| item.calc_layout(self, y_coordinate) }
    end
    
    # ratio is: x_coordinate / x_axis_length = ( date - date_range.begin ) / date_range_length
    def date_to_x_coordinate(date)
      date_from, date_to = Date.new(x_axis_dates.first,1,1), Date.new(x_axis_dates.last,1,1)
      date_range_length = date_to.jd - date_from.jd      
      ( x_axis_length * ( date.jd - date_from.jd ) * 1.0 ) / date_range_length 
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
      @x_axis_labels ||= Builder.build_x_axis_labels(self)
    end
    
    def vertical_gridlines
      @vertical_gridlines ||= x_axis_label_x_coordinates.map { |x| GridLine.build_vgridline(xy(x, 0), xy(x, y_axis_length)) }
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
