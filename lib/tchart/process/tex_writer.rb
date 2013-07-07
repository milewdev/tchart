module TChart
  
  #
  # Writes TeX code to a file.
  #
  module TeXWriter
    def self.write(tex_filename, tex_content)
      File.open(tex_filename, 'w') {|f| f.puts(tex_content)}
    end
  end
  
end
