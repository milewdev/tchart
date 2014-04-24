require 'coveralls'           # must be before everything else
Coveralls.wear!

require 'minitest/autorun'
require 'mocha/setup'         # must be after require 'minitest/autorun'

require_relative '../lib/tchart'


#
# Many of our classes do not require the == operator in the application,
# but having it helps in testing.  For example:
#
#   ChartBuilder.build(...).elements[x].must_equal Bar.new(...)
#
module TChart
  
  class Bar
    def ==(other)
      [ from, to, style ] == [ other.from, other.to, style ]
    end
  end

  class Coordinate
    def ==(other)
      [ x, y ] == [ other.x, other.y ]
    end
  end
  
  class GridLine
    def ==(other)
      [ from, to ] == [ other.from, other.to ]
    end
  end

  class Label
    def ==(other)
      [ coord, width, style, text ] == [ other.coord, other.width, other.style, other.text ]
    end
  end
  
end


#
# Helper methods/functions to make writing tests a bit easier and hopefully clearer.
#
module TestHelper
  
  #
  # Write dr('2000.3.14..2001.8.2') instead of
  # Date.new(2000,3,14)..Date.new(2001,8,2).
  #
  def dr(range_as_string)
    from, to = range_as_string.split('-').map { |date_as_string| Date.parse(date_as_string) }
    from..to
  end

  #
  # Write make_items_with_ranges('2000.3.14..2001.8.2', ...) instead of
  # [ stub( :date_ranges => [ Date.new(2000,3,14)..Date.new(2001,8,2)] ), ... ].
  #
  def make_items_with_ranges(*ranges_as_strings)
    ranges_as_strings.map { |range_as_string| stub( :date_ranges => [dr(range_as_string)] ) }
  end
  
  #
  # Write make_tick_dates(2000, 2008, 2) instead of
  # [ Date.new(2000,1,1), Date.new(2002,1,1), Date.new(2004,1,1), Date.new(2006,1,1), Date.new(2008,1,1) ]
  #
  def make_tick_dates(from_year, to_year, interval)
    (from_year..to_year).step(interval).map { |year| Date.new(year,1,1) }
  end
  
  #
  # Returns a stub of Settings.
  #
  def make_settings
    stub( 
      chart_width: 130, 
      x_axis_label_width: 10, 
      y_axis_label_width: 20, 
      line_height: 4, 
      x_axis_label_y_coordinate: -3 )
  end

end

