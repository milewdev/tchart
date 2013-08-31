module TChart
  class SettingsParser
    
    attr_reader :settings
    
    def initialize
      @settings = Settings.new
    end
    
    def parse(line) # => true or false
      return false if ! match = /^([^=]+)=(.+)$/.match(line)
      name, value = match[1].strip, match[2].strip
      raise_unknown_setting(name) if not settings.has_setting?(name)
      raise_not_a_recognizable_value(value) if not recognizable_value?(value)
      save_setting(name, value)
      true
    end

  private

    def recognizable_value?(value)
      value =~ /^(\+|-)?\d+(\.\d*)?$/
    end

    def save_setting(name, value)
      value = value.to_f
      settings.send("#{name}=", value)
    end

    def raise_unknown_setting(name)
      raise TChartError, "unknown setting \"#{name}\"; expecting one of: #{settings.setting_names.join(', ')}"
    end

    def raise_not_a_recognizable_value(value)
      raise TChartError, "\"#{value}\" is not a recognizable setting value; expecting e.g. 123 or 123.45"
    end
    
  end
end
