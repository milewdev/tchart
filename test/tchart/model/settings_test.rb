require_relative '../../test_helper'

module TChart
  describe Settings, "initialize" do
    it "sets its settings to default values" do
      settings = Settings.new
      settings.setting_names.each do |setting_name|
        settings.send(setting_name).wont_be_nil "\"#{setting_name}\" is not being set to a default value in Settings#initialize"
      end
    end
  end
  
  describe Settings, "has_setting?" do
    it "returns true if the setting exists" do
      Settings.new.has_setting?('chart_width').must_equal true
    end
    it "returns false if the setting does not exist" do
      Settings.new.has_setting?('gobbledygook').must_equal false
    end
    it "returns false when asked about itself" do
      Settings.new.has_setting?('has_setting?').must_equal false
    end
  end
  
  describe Settings, "setting_names" do
    it "returns the list of setting names" do
      Settings.new.setting_names.must_equal ['chart_width', 'line_height', 'x_item_label_width', 
        'x_item_y_coordinate', 'y_item_label_width']
    end
  end
end
