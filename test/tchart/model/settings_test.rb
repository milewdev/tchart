require_relative '../../test_helper'

module TChart
  describe Settings, "initialize" do
    before do
      @settings = Settings.new
    end
    it "sets its settings to default values" do
      @settings.setting_names.each do |setting_name|
        @settings.send(setting_name).wont_be_nil "\"#{setting_name}\" is not being set to a default value in Settings#initialize"
      end
    end
  end
  
  describe Settings, "has_setting?" do
    before do
      @settings = Settings.new
    end
    it "returns true if the setting exists" do
      @settings.has_setting?('chart_width').must_equal true
    end
    it "returns false if the setting does not exist" do
      @settings.has_setting?('gobbledygook').must_equal false
    end
    it "returns false when asked about itself" do
      @settings.has_setting?('has_setting?').must_equal false
    end
  end
  
  describe Settings, "setting_names" do
    before do
      @settings = Settings.new
    end
    it "returns the list of setting names" do
      @settings.setting_names.must_equal ['chart_width', 'line_height', 'x_axis_label_width', 
        'x_axis_label_y_coordinate', 'y_item_label_width']
    end
  end
end
