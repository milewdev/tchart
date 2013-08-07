require 'minitest/autorun'
require 'minitest/focus'
require 'mocha/setup'         # must be after require 'minitest/autorun'

require_relative '../lib/tchart/main'

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
      [ from, to, style ] == [ other.from, other.to, other.style ]
    end
  end

  class Label
    def ==(other)
      [ coord, width, style, text ] == [ other.coord, other.width, other.style, other.text ]
    end
  end

  class XItem
    def ==(other)
      [ year, x ] == [ other.year, other.x ]
    end
  end
  
end
