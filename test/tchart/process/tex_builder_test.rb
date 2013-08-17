require_relative '../../test_helper'

module TChart
  describe TeXBuilder, "comment" do
    before do
      @tex = TeXBuilder.new
    end
    it "generates a TeX comment" do
      @tex.comment "this is a comment"
      @tex.to_s.must_equal "% this is a comment\n"
    end
    it "escapes TeX special characters in comments" do
      @tex.comment "this is a comment with TeX special characters: # & |"
      @tex.to_s.must_equal "% this is a comment with TeX special characters: \\# \\& \\|\n"
    end
    it "handles non-string arguments" do
      @tex.comment 123
      @tex.to_s.must_equal "% 123\n"
    end
  end
  
  describe TeXBuilder, "line" do
    before do
      @tex = TeXBuilder.new
    end
    it "generates a TikZ code for a line" do
      @tex.line xy(10,20), xy(30,40), "line_style"   # x1, y1, x2, y2, style
      @tex.to_s.must_equal "\\draw [line_style] (10.00mm, 20.00mm) -- (30.00mm, 40.00mm);\n"
    end
  end
  
  describe TeXBuilder, "label" do
    before do
      @tex = TeXBuilder.new
    end
    it "generates TikZ code for a chart label" do
      @tex.label xy(10,20), 15, 'some_style', 'the label text'  # x_mid, y, width, style, text
      @tex.to_s.must_equal "\\node [some_style, text width = 15.00mm] at (10.00mm, 20.00mm) {the label text};\n"
    end
    it "escapes TeX special characters in the label text" do
      @tex.label xy(10,20), 15, 'some_style', 'TeX special characters: # &'  # x_mid, y, width, style, text
      @tex.to_s.must_equal "\\node [some_style, text width = 15.00mm] at (10.00mm, 20.00mm) {TeX special characters: \\# \\&};\n"
    end
    it "handles non-string label text" do
      @tex.label xy(10,20), 15, 'some_style', 123  # x_mid, y, width, style, text
      @tex.to_s.must_equal "\\node [some_style, text width = 15.00mm] at (10.00mm, 20.00mm) {123};\n"
    end
  end
  
  describe TeXBuilder, "bar" do
    before do
      @tex = TeXBuilder.new
    end
    it "generates TikZ code for a horizontal bar on the chart" do
      @tex.bar xy(10,50), xy(40,50), 'some_style'  # from, to, style
      @tex.to_s.must_equal "\\node [some_style] at (25.00mm, 50.00mm) [minimum width = 30.00mm] {};\n"
    end
  end
  
  describe TeXBuilder, "newline" do
    before do
      @tex = TeXBuilder.new
    end
    it "generates a blank line" do
      @tex.newline
      @tex.to_s.must_equal "\n"
    end
  end
  
  describe TeXBuilder, "echo" do
    before do
      @tex = TeXBuilder.new
    end
    it "returns the passed argument" do
      @tex.echo "some text"
      @tex.to_s.must_equal "some text"
    end
  end
  
  describe TeXBuilder, "to_s" do
    before do
      @tex = TeXBuilder.new
    end
    it "returns the generated TeX code" do
      @tex.comment "a comment"
      @tex.echo "some text\n"
      @tex.to_s.must_equal "% a comment\nsome text\n"
    end
  end
end
