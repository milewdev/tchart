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
    
    def x_axis_dates
      @x_axis_dates ||= derive_x_axis_dates
    end
    
    def x_axis_label_x_coordinates
      @x_axis_label_x_coordinates ||= derive_x_axis_label_x_coordinates
    end
    
    def frame
      @frame ||= Frame.new(self)
    end
    
    def items_date_range
      @items_date_range ||= derive_items_date_range
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
      x_axis_labels.each { |label| label.render(tex) }
      items.each { |item| item.render(tex) }
      tex.echo "\n\\endtikzpicture\n"
      tex.to_s
    end
    
  private
  
    def item_y_coordinates
      (line_height * items.length).step(line_height, -line_height)
    end
    
    def derive_x_axis_dates
      # try a date for each year in the items date range
      from_year = items_date_range.begin.year         # round down to Jan 1st of year
      to_year = items_date_range.end.year + 1         # +1 to round up to Jan 1st of the following year
      return (from_year..to_year).step(1) if to_year - from_year <= 10

      # try a date every five years
      from_year = (from_year / 5.0).floor * 5         # round down to nearest 1/2 decade
      to_year = (to_year / 5.0).ceil * 5              # round up to nearest 1/2 decade
      return (from_year..to_year).step(5) if to_year - from_year <= 50

      # use a date every 10 years
      from_year = (from_year / 10.0).floor * 10       # round down to nearest decade
      to_year = (to_year / 10.0).ceil * 10            # round up to nearest decade
      return (from_year..to_year).step(10)
    end
  
    def derive_items_date_range
      from = nil
      to = nil
      items.each do |chart_item|
        # TODO: this belongs in ChartItem
        chart_item.date_ranges.each do |date_range|
          from = date_range.begin if from.nil? or date_range.begin < from
          to = date_range.end if to.nil? or to < date_range.end
        end
      end
      # TODO: refactor: put this somewhere else
      current_year = Date.today.year
      from ||= Date.new(current_year, 1, 1)
      to ||= Date.new(current_year, 12, 31)
      from..to
    end
    
    def derive_x_axis_label_x_coordinates
      num_coords = x_axis_dates.size
      x_interval = x_axis_length / (num_coords - 1.0)
      (0..x_axis_length).step(x_interval)
    end
    
  end
end
