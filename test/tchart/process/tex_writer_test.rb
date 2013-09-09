require_relative '../../test_helper'

module TChart
  describe TeXWriter, "write" do
    
    before do
      @filename = "_test_.tex"
      @content = "some content\n"
      File.delete(@filename) if File.exists?(@filename)
    end
    
    after do
      File.delete(@filename) if File.exists?(@filename)
    end
    
    it "writes output" do
      TeXWriter.write(@filename, @content)
      File.exists?(@filename).must_equal true
      IO.read(@filename).must_equal @content
    end
    
    it "silently overwrites an already existing output file" do
      File.open(@filename, 'w') { |f| f.write('should be overwritten') }
      TeXWriter.write(@filename, @content)
      IO.read(@filename).must_equal @content
    end
    
    it "throws a 'not writable' error if the output file already exists and cannot be overwritten" do
      begin
        Dir.mkdir(@filename)
        proc { TeXWriter.write(@filename, @content) }.must_raise Errno::EISDIR
      ensure
        Dir.rmdir(@filename)
      end
    end
  
  end
end
