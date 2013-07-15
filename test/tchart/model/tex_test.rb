require_relative '../../test_helper'

module TChart
  describe Tex, "comment" do
    it "generates a TeX comment" do
      output = StringIO.new
      Tex.new(output).comment "this is a comment"
      output.string.must_equal "% this is a comment\n"
    end
    it "escapes TeX special characters in comments" do
      output = StringIO.new
      Tex.new(output).comment "this is a comment with TeX special characters: # &"
      output.string.must_equal "% this is a comment with TeX special characters: \\# \\&\n"
    end
    it "handles non-string arguments" do
      output = StringIO.new
      Tex.new(output).comment 123
      output.string.must_equal "% 123\n"
    end
  end
  
  describe Tex, "line" do
    it "generates a TikZ code for a line" do
      output = StringIO.new
      Tex.new(output).line 10, 20, 30, 40   # x1, y1, x2, y2
      output.string.must_equal "\\draw [draw = black!5] (10.00mm, 20.00mm) -- (30.00mm, 40.00mm);\n"
    end
  end
  
  describe Tex, "label" do
    it "generates TikZ code for a chart label" do
      output = StringIO.new
      Tex.new(output).label 10, 20, 15, 'some_style', 'the label text'  # x_mid, y, width, style, text
      output.string.must_equal "\\node [some_style, text width = 15.00mm] at (10.00mm, 20.00mm) {the label text};\n"
    end
    it "escapes TeX special characters in the label text" do
      output = StringIO.new
      Tex.new(output).label 10, 20, 15, 'some_style', 'TeX special characters: # &'  # x_mid, y, width, style, text
      output.string.must_equal "\\node [some_style, text width = 15.00mm] at (10.00mm, 20.00mm) {TeX special characters: \\# \\&};\n"
    end
    it "handles non-string label text" do
      output = StringIO.new
      Tex.new(output).label 10, 20, 15, 'some_style', 123  # x_mid, y, width, style, text
      output.string.must_equal "\\node [some_style, text width = 15.00mm] at (10.00mm, 20.00mm) {123};\n"
    end
  end
  
  describe Tex, "bar" do
    it "generates TikZ code for a horizontal bar on the chart" do
      output = StringIO.new
      Tex.new(output).bar 10, 40, 50, 'some_style'  # x1, x2, y, style
      output.string.must_equal "\\node [some_style] at (25.00mm, 50.00mm) [minimum width = 30.00mm] {};\n"
    end
  end
  
  describe Tex, "newline" do
    it "generates a blank line" do
      output = StringIO.new
      Tex.new(output).newline
      output.string.must_equal "\n"
    end
  end
  
  describe Tex, "echo" do
    it "returns the passed argument" do
      output = StringIO.new
      Tex.new(output).echo "some text"
      output.string.must_equal "some text"
    end
  end
end