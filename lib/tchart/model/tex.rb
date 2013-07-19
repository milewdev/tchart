#
# SMELL: rename to TexBuilder
#

require 'stringio'

module TChart
  class Tex
    
    def initialize
      @output = StringIO.new
    end
    
    def echo(text)
      @output << text
    end
    
    def comment(text)
      @output << "% #{escape_tex_special_chars text.to_s}\n"
    end
    
    def line(x1, y1, x2, y2, style = "draw = black!5")    # TODO: get rid of style default value
      @output << "\\draw [#{style}] (#{f x1}mm, #{f y1}mm) -- (#{f x2}mm, #{f y2}mm);\n"
    end
    
    def self.line(from, to, style)
      "\\draw [#{style}] (#{f from.x}mm, #{f from.y}mm) -- (#{f to.x}mm, #{f to.y}mm);\n"
    end
    
    def label(x_mid, y, width, style, text)
      @output << "\\node [#{style}, text width = #{f width}mm] at (#{f x_mid}mm, #{f y}mm) {#{escape_tex_special_chars text.to_s}};\n"
    end
    
    def bar(x1, x2, y, style)
      x_mid, width = to_tikz_coords(x1, x2)
      @output << "\\node [#{style}] at (#{f x_mid}mm, #{f y}mm) [minimum width = #{f width}mm] {};\n"
    end
    
    def newline
      @output << "\n"
    end
    
    def to_s
      @output.string
    end
    
  private
  
    # f(1.2345) => 1.23
    def self.f(number)
      '%.02f' % number
    end
    
    def f(number)
      Tex.f(number)
    end
    
    # escape_tex_special_chars("a#b&c") => "a\#b\&c"
    def escape_tex_special_chars(text) # => String
      text.gsub(/([#&])/, '\\\\\\1')
    end
    
    # to_tikx_coords(x1, x2) => x_mid, width
    def to_tikz_coords(x1, x2)
      width = x2 - x1
      x_mid = x1 + (width / 2.0)
      [x_mid, width]
    end
  
  end
end
