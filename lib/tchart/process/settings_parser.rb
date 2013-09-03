module TChart
  class SettingsParser
    
    attr_reader :settings
    
    def initialize
      @settings = Settings.new
    end
    
    def parse(line) # => true if a settings line, false otherwise.
      return false if ! match = /^([^=]+)=(.+)$/.match(line)
      name, value_as_string = match[1].strip, match[2].strip
      raise_unknown_setting(name) if ! known_setting?(name)
      raise_not_a_recognizable_value(value_as_string) if ! recognizable_value?(value_as_string)
      save_setting(name, value_as_string)
      true
    end

  private
  
    def known_setting?(name)
      settings.has_setting?(name)
    end

    def recognizable_value?(value_as_string)
      value_as_string =~ /^(\+|-)?\d+(\.\d*)?$/
    end

    def save_setting(name, value_as_string)
      settings.send("#{name}=", value_as_string.to_f)
    end
    
    def raise_unknown_setting(name)
      raise TChartError, "unknown setting \"#{name}\"; expecting one of: #{settings.setting_names.join(', ')}"
    end

    def raise_not_a_recognizable_value(value_as_string)
      raise TChartError, "\"#{value_as_string}\" is not a recognizable setting value; expecting e.g. 123 or 123.45"
    end
    
  end
end