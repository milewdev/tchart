require 'stringio'

module TChart
  
  #
  # Responsible for generating TikZ/TeX code for the various chart elements,
  # including labels, bars, (grid)lines, etc.  Also responsible for escaping
  # TeX special characters, such as {, }, \, etc., and for accumulating the
  # generated code.
  #
  class TeXBuilder
    
    def initialize
      @output = StringIO.new
    end
    
    def begin_chart
      @output << "\\tikzpicture\n"
    end
    
    def end_chart
      @output << "\\endtikzpicture\n"
    end
    
    def comment(text)
      @output << "% #{escape_tex_special_chars text.to_s}\n"
    end
    
    def gridline(from, to, style)
      @output << "\\draw [#{style}] (#{f from.x}mm, #{f from.y}mm) -- (#{f to.x}mm, #{f to.y}mm);\n"
    end
    
    def label(coord, width, style, text)
      @output << "\\node [#{style}, text width = #{f width}mm] at (#{f coord.x}mm, #{f coord.y}mm) {#{escape_tex_special_chars text.to_s}};\n"
    end
    
    def bar(from, to, style)
      x_mid, width = to_tikz_coords(from.x, to.x)
      @output << "\\node [#{style}] at (#{f x_mid}mm, #{f from.y}mm) [minimum width = #{f width}mm] {};\n"
    end
    
    def to_s # => String
      @output.string
    end
    
  private

    #
    # f(1.2345)  =>  "1.23"
    #
    def f(number)
      '%.02f' % number
    end
    
    #
    # escape_tex_special_chars('# $ % & _ { } \ ~ ^ |')  =>  '\# \$ \% \& \_ \{ \} \textbackslash{} \~{} \^{} $\vert$'
    #
    def escape_tex_special_chars(text)
      text.gsub(/([#$%&_{}~^\\|])/) do |match|
        case match
        when '#', '$', '%', '&', '_', '{', '}'
          "\\#{match}"
        when '\\'
          '$\\backslash$'
        when '~'
          '\\~{}'
        when '^'
          '\\^{}'
        when '|'
          '$\\vert$'
        end
      end
    end
    
    #
    # to_tikx_coords(x_from, x_to)  =>  [ x_mid, width ]
    #
    def to_tikz_coords(x_from, x_to)
      width = x_to - x_from
      x_mid = x_from + (width / 2.0)
      [x_mid, width]
    end
  
  end
end
