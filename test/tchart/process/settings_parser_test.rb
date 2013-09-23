require_relative "../../test_helper"

module TChart
  describe SettingsParser, "parse" do
    
    before do
      @parser = SettingsParser.new
    end
    
    it "returns true if the passed line is recognized as a setting" do
      @parser.parse?("chart_width=42").must_equal true
      @parser.parse?("chart_width = 42").must_equal true
    end
    
    it "returns false if the passed line is not recognizable as a setting" do
      @parser.parse?("C++ | lang | 2003").must_equal false
    end
    
    it "parses settings with no sign" do
      @parser.parse?("chart_width=42\n")
      @parser.settings.chart_width.must_equal 42
    end
    
    it "parses settings with a plus sign" do
      @parser.parse?("chart_width=+42\n")
      @parser.settings.chart_width.must_equal 42
    end
    
    it "parses settings with a minus sign" do
      @parser.parse?("chart_width=-42\n")
      @parser.settings.chart_width.must_equal (-42)
    end
    
    it "parses settings with a decimal but no decimal places" do
      @parser.parse?("chart_width=42.\n")
      @parser.settings.chart_width.must_equal 42
    end
    
    it "parses settings with decimal places" do
      @parser.parse?("chart_width=42.24\n")
      @parser.settings.chart_width.must_equal 42.24
    end
    
    it "parses settings with trailing zeros after the decimal place" do
      @parser.parse?("chart_width=42.240\n")
      @parser.settings.chart_width.must_equal 42.24
    end
    
    it "parses settings with leading zeros" do
      @parser.parse?("chart_width=0042\n")
      @parser.settings.chart_width.must_equal 42
    end
    
    it "ignores spaces around the equals sign in a setting" do
      @parser.parse?("chart_width = 42\n")
      @parser.settings.chart_width.must_equal 42
    end
    
    it "ignores leading spaces before the setting name" do
      @parser.parse?(" chart_width=42\n")
      @parser.settings.chart_width.must_equal 42
    end
    
    it "returns an error if the settings value is not a number for numeric settings" do
      error = ->{ @parser.parse?("chart_width=42mm\n") }.must_raise TChartError
      error.message.must_equal "\"42mm\" is not a recognizable setting value; expecting e.g. 123 or 123.45"
    end
    
    it "returns an error if the setting name is unknown" do
      error = ->{ @parser.parse?("unknown=42\n") }.must_raise TChartError
      error.message.must_match( /^unknown setting \"unknown\"; expecting one of:/ )
    end
 
  end
end
