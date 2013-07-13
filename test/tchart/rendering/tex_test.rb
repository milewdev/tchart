require_relative '../../test_helper'

module TChart
  describe Tex, "comment" do
    it "generates a TeX comment" do
      output = StringIO.new
      tex output do
        comment "this is a comment"
      end
      output.string.must_equal "% this is a comment\n"
    end
    it "escapes TeX special characters in comments" do
      output = StringIO.new
      tex output do
        comment "this is a comment with TeX special characters: # &"
      end
      output.string.must_equal "% this is a comment with TeX special characters: \\# \\&\n"
    end
  end
  
  describe Tex, "line" do
    it "generates a TikZ code for a line" do
      output = StringIO.new
      tex output do
        line 10, 20, 30, 40   # x1, y1, x2, y2
      end
      output.string.must_equal "\\draw [draw = black!5] (10.00mm, 20.00mm) -- (30.00mm, 40.00mm);\n"
    end
  end
  
  describe Tex, "label" do
    it "generates TikZ code for a chart label" do
      output = StringIO.new
      tex output do
        label 10, 20, 15, 'some_style', 'the label text'  # x_mid, y, width, style, text
      end
      output.string.must_equal "\\node [some_style, text width = 15.00mm] at (10.00mm, 20.00mm) {the label text};\n"
    end
    it "escapes TeX special characters in the label text" do
      output = StringIO.new
      tex output do
        label 10, 20, 15, 'some_style', 'TeX special characters: # &'  # x_mid, y, width, style, text
      end
      output.string.must_equal "\\node [some_style, text width = 15.00mm] at (10.00mm, 20.00mm) {TeX special characters: \\# \\&};\n"
    end
  end
  
  describe Tex, "bar" do
    it "generates TikZ code for a horizontal bar on the chart" do
      output = StringIO.new
      tex output do
        bar 10, 40, 50, 'some_style'  # x1, x2, y, style
      end
      output.string.must_equal "\\node [some_style] at (25.00mm, 50.00mm) [minimum width = 30.00mm] {};\n"
    end
  end
end
