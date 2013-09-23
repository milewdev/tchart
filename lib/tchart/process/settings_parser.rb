module TChart
  
  #
  # Responsible for parsing a line of source data that contains a
  # setting.  Also responsible for accumulating parsed settings.
  #
  class SettingsParser
   
    #
    # The accumulated settings.  All settings start with their default
    # values and get updated as setting lines are parsed.  If a setting
    # is specified more than once in the source data, the last value 
    # found will be the one used.
    #
    attr_reader :settings
    
    def initialize
      @settings = Settings.new
    end
    
    #
    # Return true if the passed line is a recognizable settings line
    # (which may nonetheless have errors, such as unknown setting, etc.), 
    # false otherwise.
    #
    def parse?(line)
      return false if (match = /^([^=]+)=(.+)$/.match(line)).nil?
      name, value_as_string = match[1].strip, match[2].strip
      raise_unknown_setting(name) unless known_setting?(name)
      raise_not_a_recognizable_value(value_as_string) unless recognizable_value?(value_as_string)
      save_setting(name, value_as_string)
      true
    end

  private
  
    def known_setting?(name)
      @settings.has_setting?(name)
    end

    #
    # "chart_width = 42"      => true
    # "gobbledygook = junk"   => true
    # "chart_width 42"        => false
    #
    def recognizable_value?(value_as_string)
      value_as_string =~ /^(\+|-)?\d+(\.\d*)?$/
    end

    def save_setting(name, value_as_string)
      @settings.send("#{name}=", value_as_string.to_f)
    end
    
    def raise_unknown_setting(name)
      raise TChartError, "unknown setting \"#{name}\"; expecting one of: #{@settings.setting_names.join(', ')}"
    end

    def raise_not_a_recognizable_value(value_as_string)
      raise TChartError, "\"#{value_as_string}\" is not a recognizable setting value; expecting e.g. 123 or 123.45"
    end
    
  end
end
