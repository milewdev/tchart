module TChart
  class Settings
    
    attr_accessor :chart_width
    attr_accessor :line_height
    attr_accessor :x_label_width
    attr_accessor :x_label_y_coordinate
    attr_accessor :y_label_width
    
    # All values are in millimeters.
    def initialize
      @chart_width              = 164.99
      @x_label_width            = 10
      @x_label_y_coordinate     = -3
      @line_height              = 4.6
      @y_label_width            = 24
    end
    
    def setting_names
      methods
        .grep(/\w=$/)
        .map {|name| name.to_s.chomp('=')}
    end
    
    def has_setting?(setting_name)
      setting_names.include?(setting_name)
    end
    
  end
end
