require_relative '../../test_helper'

module Resume
  describe TeXWriter, "write" do
    before do
      @filename = "_test_.tex"
      File.delete(@filename) if File.exists?(@filename)
    end
    after do
      File.delete(@filename) if File.exists?(@filename)
    end
    it "writes output" do
      content = "some content\n"
      TeXWriter.write(@filename, content)
      File.exists?(@filename).must_equal true
      IO.read(@filename).must_equal content
    end
  end
end
