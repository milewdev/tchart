module TChart
  class Settings
    
    attr_accessor :chart_width                # Include y-axis labels and the plot area.
    attr_accessor :line_height                # The height of y-axis labels and bars.
    attr_accessor :x_axis_label_width         # Used to determine left and right plot area margins.
    attr_accessor :x_axis_label_y_coordinate  # Vertical mid-point where x-axis labels are located.
    attr_accessor :y_axis_label_width         # Used to calculate plot area, and required by TeX to do left justification.
    
    # All values are in millimeters.
    def initialize
      @chart_width                = 164.99
      @line_height                = 4.6
      @x_axis_label_width         = 10
      @x_axis_label_y_coordinate  = -3
      @y_axis_label_width         = 24
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
