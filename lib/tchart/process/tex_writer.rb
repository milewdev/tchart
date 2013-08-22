module TChart
  module TeXWriter
    
    def self.write(tex_filename, tex_content)
      File.open(tex_filename, 'w') {|f| f.puts(tex_content)}
    end
    
  end
end
