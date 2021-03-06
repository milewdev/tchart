require_relative '../../test_helper'

module TChart
  describe TeXBuilder, "begin_chart" do
    
    before do
      @tex = TeXBuilder.new
    end
    
    it "generates \\tikzpicture" do
      @tex.begin_chart
      @tex.to_s.must_equal "\\tikzpicture\n"
    end
    
  end
  
  
  describe TeXBuilder, "end_chart" do
    
    before do
      @tex = TeXBuilder.new
    end
    
    it "generates \\endtikzpicture" do
      @tex.end_chart
      @tex.to_s.must_equal "\\endtikzpicture\n"
    end
    
  end
  
  
  describe TeXBuilder, "comment" do
    
    before do
      @tex = TeXBuilder.new
    end
    
    it "generates a TeX comment" do
      @tex.comment "this is a comment"
      @tex.to_s.must_equal "% this is a comment\n"
    end
    
    it "escapes TeX special characters in comments" do
      @tex.comment '# $ % & _ { } \ ~ ^ |'
      @tex.to_s.must_include '\# \$ \% \& \_ \{ \} $\backslash$ \~{} \^{} $\vert$'
    end
    
    it "handles non-string arguments" do
      @tex.comment 123
      @tex.to_s.must_equal "% 123\n"
    end
    
  end
  
  
  describe TeXBuilder, "gridline" do
  
    before do
      @tex = TeXBuilder.new
    end
  
    it "generates a TikZ code for a grid line" do
      @tex.gridline xy(10,20), xy(30,40), "line_style"   # x1, y1, x2, y2, style
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
      @tex.label xy(10,20), 15, 'some_style', 'TeX special characters: # $ % & _ { } \ ~ ^ |'  # x_mid, y, width, style, text
      @tex.to_s.must_include '{TeX special characters: \# \$ \% \& \_ \{ \} $\backslash$ \~{} \^{} $\vert$}'
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
  
  
  describe TeXBuilder, "to_s" do
  
    before do
      @tex = TeXBuilder.new
    end
  
    it "returns the generated TeX code" do
      @tex.comment "a comment"
      @tex.to_s.must_equal "% a comment\n"
    end
  
  end
end
