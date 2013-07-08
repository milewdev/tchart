module TChart
  class ItemRenderer
    def initialize(settings)
      @settings = settings
    end
    
    def render(item)
      # TODO: indentation should be done where?
      (generate_item_comment(item) + generate_item_y_label(item) + generate_item_bars(item)).indent(4)
    end
    
    def generate_item_comment(item)
      "% #{escape_tex_special_chars item.name}\n"
    end
    
    def generate_item_y_label(item)
      mid_point, width = @settings.y_label_width / -2.0, @settings.y_label_width
      "\\node [ylabel, text width = #{f width}mm] at (#{f mid_point}mm, #{f item.y_coordinate}mm) {#{escape_tex_special_chars item.name}};\n"
    end
    
    def generate_item_bars(item)
      item.bar_x_coordinates
        .map { |bar_x_coordinates| generate_item_bar(item, bar_x_coordinates) }
        .join
    end
    
    def generate_item_bar(item, bar_x_coordinates)
      "\\node [#{item.style}] at (#{f bar_x_coordinates.mid_point}mm, #{f item.y_coordinate}mm) [minimum width = #{f bar_x_coordinates.width}mm] {};\n"
    end

    # f(1.2345) => 1.23
    # TODO: to be moved into base class or utilities module
    def f(number) # => String
      '%.02f' % number
    end
    
    # escape_tex_special_chars("a#b&c") => "a\#b\&c"
    def escape_tex_special_chars(text) # => String
      text.gsub(/([#&])/, '\\\\\\1')
    end
  end
end
