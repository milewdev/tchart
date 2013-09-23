module TChart
  
  #
  # The input data file specifies settings, data lines, and separators.
  # This class stores the settings from the data file.  Responsible for
  # providing default values for those settings that are not specified
  # in the input file.  Also responsible for answering whether a setting
  # name is known or not, and for providing a list of all setting names.
  #
  # All setting values are in millimeters.  The Settings and TeXBuilder
  # are the only two classes that know what units are being used.  All
  # other classes are unit agnostic.
  #
  class Settings
    
    #
    # The amount of horizontal space available for the chart.  It must be
    # large enough to accomodate the width of the y-axis labels, the width
    # of the x axis, and the margins to the left and right of the x axis.
    #
    attr_accessor :chart_width
    
    #
    # The amount of vertical space to allocate for each line of the chart.
    # It must be large enough to accomodate the larger of the y axis label 
    # height and the bar height.
    #
    attr_accessor :line_height

    #
    # The amount of horizontal space to allocate for each x axis label.
    # Used to determine the width of the margins to the left and right of
    # the x axis, and also passed to TikZ/TeX.
    #
    attr_accessor :x_axis_label_width

    #
    # The distance of the mid point of the x axis labels from the x axis.
    #
    attr_accessor :x_axis_label_y_coordinate

    #
    # The width of the y axis labels.  Used to calculate the amount of 
    # horizontal space to leave for the labels, and also passed in the
    # generated TikX code.
    #
    attr_accessor :y_axis_label_width
    
    def initialize
      @chart_width                = 164.99
      @line_height                = 4.6
      @x_axis_label_width         = 10
      @x_axis_label_y_coordinate  = -3
      @y_axis_label_width         = 24
    end
    
    def has_setting?(setting_name)
      setting_names.include?(setting_name)
    end
   
    def setting_names # => [ "chart_width", "line_height", ... ]
      methods                                 # => [ "has_setting?", "chart_width", "chart_width=", ... ]
        .grep(/\w=$/)                         # => [ "chart_width=", ... ]
        .map {|name| name.to_s.chomp('=')}    # => [ "chart_width", ... ]
    end
    
  end
end
