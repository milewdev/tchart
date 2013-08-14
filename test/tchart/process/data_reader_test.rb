require_relative '../../test_helper'
require 'stringio'

module TChart
  describe DataReader, "read" do
    before do
      @filename = "_test_.txt"
      @old_stderr, $stderr = $stderr, StringIO.new
    end
    after do
      File.delete(@filename) if File.exists?(@filename)
      $stderr = @old_stderr
    end
    it "returns chart items and settings" do
      File.open(@filename, 'w') { |f| f.puts("C\tlang\t2001.1-2001.11\nchart_width=50\n") }
      settings, items = DataReader.read(@filename)
      settings.wont_be_nil
      items.wont_be_nil
    end
    it "throws an exception if errors are found in the input data" do
      File.open(@filename, 'w') { |f| f.puts("C\tlang\t2001.1-2001.11\nchart_width=24mm\n") }
      proc { DataReader.read(@filename) }.must_raise TChartError
    end
    it "dumps input data errors to stderr" do
      File.open(@filename, 'w') { |f| f.puts("C\tlang\t2001.1-2001.11\nchart_width=24mm\n") }
      # cannot use proc { ... } as it munges StringIO'd $stderr for some reason
      # TODO: likely can use proc { ... }; just need to keep the begin/rescue/end
      begin
        DataReader.read(@filename)
      rescue   
        # eat and ignore exception
      end
      $stderr.string.must_equal "_test_.txt, 2: \"24mm\" is not a number; expecting e.g. 123 or 123.45\n"
    end
  end
end
