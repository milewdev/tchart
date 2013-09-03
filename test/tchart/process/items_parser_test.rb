require_relative '../../test_helper'

module TChart  
  describe ItemsParser, "parse" do
    before do
      @parser = ItemsParser.new
    end
    it "parses chart items" do
      @parser.parse("Description | Style | 2000.4.14-2001.2.22\n")
      @parser.items[0].description.must_equal 'Description'
      @parser.items[0].bar_style.must_equal 'Style'
      @parser.items[0].date_ranges.must_equal [ Date.new(2000,4,14)..Date.new(2001,2,22) ]
    end
    it "raises an error if the name is missing" do
      error = ->{ @parser.parse("|Style|2001\n") }.must_raise TChartError
      error.message.must_equal "description is missing"
    end
    it "raises an error if dates where supplied but the style is missing" do
      error = ->{ @parser.parse("Description||2001\n") }.must_raise TChartError
      error.message.must_equal "style is missing"
    end
    it "ignores escaped separator characters" do
      @parser.parse("Description1\\|\\|Description2|Style|2000\n")
      @parser.items[0].description.must_equal 'Description1||Description2'
      @parser.items[0].bar_style.must_equal 'Style'
      @parser.items[0].date_ranges.must_equal [ Date.new(2000,1,1)..Date.new(2000,12,31) ]
    end
    it "allows separator lines" do
      @parser.parse("---\n")
      @parser.items[0].must_be_instance_of Separator
    end
    it "allows chart items with no date ranges" do
      @parser.parse("Description | Style\n")
      @parser.items[0].description.must_equal 'Description'
      @parser.items[0].bar_style.must_equal 'Style'
      @parser.items[0].date_ranges.must_equal []
    end
    it "allows chart items with no style and no date ranges" do
      @parser.parse("Description\n")
      @parser.items[0].description.must_equal 'Description'
      @parser.items[0].bar_style.must_equal nil
      @parser.items[0].date_ranges.must_equal []
    end
    it "allows chart items with empty style and empty date ranges" do
      @parser.parse("Description||\n")
      @parser.items[0].description.must_equal 'Description'
      @parser.items[0].bar_style.must_equal nil
      @parser.items[0].date_ranges.must_equal []
    end
    it "allows many date ranges" do
      @parser.parse("Description|Style|2000|2001|2002\n")
      @parser.items[0].date_ranges.length.must_equal 3
    end
    it "strips leading and trailing spaces from the description" do
      @parser.parse(" \t Description \t |Style\n")
      @parser.items[0].description.must_equal 'Description'
    end
    it "strips leading and trailing spaces from the style" do
      @parser.parse("Description| \t Style \t |2000\n")
      @parser.items[0].bar_style.must_equal 'Style'
    end
    it "strips leading and trailing spaces from the dates" do
      @parser.parse("Description|Style| \t 2000 \t | \t 2001 \t \n")
      @parser.items[0].date_ranges.must_equal [ Date.new(2000,1,1)..Date.new(2000,12,31), Date.new(2001,1,1)..Date.new(2001,12,31) ]
    end
    it "converts a range consisting of just a year to 1st January thru 31st December of that year" do
      @parser.parse("Description|Style|2000\n")
      @parser.items[0].date_ranges.must_equal [ Date.new(2000,1,1)..Date.new(2000,12,31) ]
    end
    it "converts a range start consisting of just a year to 1st January of the year" do
      @parser.parse("Description|Style|2000-2001.2.22\n")
      @parser.items[0].date_ranges.must_equal [ Date.new(2000,1,1)..Date.new(2001,2,22) ]
    end
    it "converts a range start consisting of a year and a month to the 1st of the month" do
      @parser.parse("Description|Style|2000.4-2001.2.22\n")
      @parser.items[0].date_ranges.must_equal [ Date.new(2000,4,1)..Date.new(2001,2,22) ]
    end
    it "converts a range end consisting of just a year to 31st December of the year" do
      @parser.parse("Description|Style|2000.4.14-2001\n")
      @parser.items[0].date_ranges.must_equal [ Date.new(2000,4,14)..Date.new(2001,12,31) ]
    end
    it "converts a range end consisting of a year and a month to the last day of the month" do
      @parser.parse("Description|Style|2000.4.14-2001.2\n")
      @parser.items[0].date_ranges.must_equal [ Date.new(2000,4,14)..Date.new(2001,2,28) ]
    end
    it "allows whitespace around the dash (-) in a date range" do
      @parser.parse("Description|Style|2000.4.14 \t - \t 2001.2.22\n")
      @parser.items[0].date_ranges.must_equal [ Date.new(2000,4,14)..Date.new(2001,2,22) ]
    end
    it "raises an error if a date cannot be parsed" do
      error = ->{ @parser.parse("Description|Style|2000.-2001\n") }.must_raise TChartError
      error.message.must_equal "bad date range \"2000.-2001\"; expecting 2000.4.17-2001.7.21, or 2000.4-2001, etc."
    end
    it "raises an error if start date in a range is invalid" do
      error = ->{ @parser.parse("Description|Style|2000.4.34-2001.2.22\n") }.must_raise TChartError
      error.message.must_equal "2000.4.34: invalid date"
    end
    it "raises an error if end date in a range is invalid" do
      error = ->{ @parser.parse("Description|Style|2000.4.14-2001.2.32\n") }.must_raise TChartError
      error.message.must_equal "2001.2.32: invalid date"
    end
    it "allows ranges to be out of order" do
      @parser.parse("Description|Style|2001|2000\n")
      @parser.items[0].date_ranges.must_equal [ Date.new(2001,1,1)..Date.new(2001,12,31), Date.new(2000,1,1)..Date.new(2000,12,31) ]
    end
    it "allows ranges to be back-to-back" do
      @parser.parse("Description|Style|2000|2001\n")
      @parser.items[0].date_ranges.must_equal [ Date.new(2000,1,1)..Date.new(2000,12,31), Date.new(2001,1,1)..Date.new(2001,12,31) ]
    end
    it "raises an error if ranges overlap" do
      error = ->{ @parser.parse("Description|Style|2000-2001|2002-2004|2003-2005|2006-2007\n") }.must_raise TChartError
      error.message.must_equal "date range 2002.1.1-2004.12.31 overlaps 2003.1.1-2005.12.31"
    end
    it "raises an error if a range end date is before a range start date" do
      error = ->{ @parser.parse("Description|Style|2001.2.22-2000.4.14\n") }.must_raise TChartError
      error.message.must_equal "date range end 2000.4.14 before start 2001.2.22"
    end
    it "raises an error if two sets of dates are not separated by a pipe" do
      error = ->{ @parser.parse("Description|Style|2001-2002 2003-2004\n") }.must_raise TChartError
      error.message.must_equal "bad date range \"2001-2002 2003-2004\"; expecting 2000.4.17-2001.7.21, or 2000.4-2001, etc."
    end
  end
end
