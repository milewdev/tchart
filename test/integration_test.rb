require_relative 'test_helper'

module TChart
  describe "integration test" do
    
    before do
      delete_test_files(data_filename, tex_filename)
    end
    
    after do
      delete_test_files(data_filename, tex_filename)
    end
    
    it do
      create_file(data_filename, data)
      TChart.run( [ data_filename, tex_filename ] )
      contents_of(tex_filename).must_equal expected_tex
    end
    
    def data_filename 
      "integration_test.txt"
    end
    
    def tex_filename
      "integration_test.tex"
    end
    
    def data
      <<-'EOS'.gsub(/^\s+/, '')
        chart_width = 100
        line_height = 5
        x_axis_label_width = 15
        x_axis_label_y_coordinate = -5
        y_axis_label_width = 30
    
        Objective-C | lang  | 2001.5-2002.6
        -----------------------------------
        OS X        | os    | 2001.3-2002.7
      EOS
    end
    
    def expected_tex
      <<-'EOS'.gsub(/^\s+/, '')
        \tikzpicture
        \draw [gridline] (0.00mm, 20.00mm) -- (55.00mm, 20.00mm);
        \draw [gridline] (0.00mm, 0.00mm) -- (55.00mm, 0.00mm);
      
        \node [xlabel, text width = 15.00mm] at (0.00mm, -5.00mm) {2001};
        \draw [gridline] (0.00mm, 0.00mm) -- (0.00mm, 20.00mm);
      
        \node [xlabel, text width = 15.00mm] at (27.50mm, -5.00mm) {2002};
        \draw [gridline] (27.50mm, 0.00mm) -- (27.50mm, 20.00mm);
      
        \node [xlabel, text width = 15.00mm] at (55.00mm, -5.00mm) {2003};
        \draw [gridline] (55.00mm, 0.00mm) -- (55.00mm, 20.00mm);
      
        \node [ylabel, text width = 30.00mm] at (-22.50mm, 15.00mm) {Objective-C};
      
        \node [lang] at (25.09mm, 15.00mm) [minimum width = 32.10mm] {};
        \draw [gridline] (0.00mm, 10.00mm) -- (55.00mm, 10.00mm);
      
        \node [ylabel, text width = 30.00mm] at (-22.50mm, 5.00mm) {OS X};
      
        \node [os] at (23.96mm, 5.00mm) [minimum width = 39.03mm] {};
        \endtikzpicture
      EOS
    end
    
    def create_file(filename, contents)
      File.open(filename, "w") { |f| f.puts(contents) }
    end
    
    def contents_of(filename)
      File.open(filename, "r") { |f| f.read }
    end
    
    def delete_test_files(*filenames)
      filenames.each { |fn| File.delete(fn) if File.exists?(fn) }
    end
    
  end
end
