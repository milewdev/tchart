require_relative '../../test_helper'
require 'stringio'

module TChart
  describe DataReader, "read" do
    before do
      @filename = "_DataReader_read_test.txt"
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
    it "throws an exception if errors are found" do
      File.open(@filename, 'w') { |f| f.puts("C\tlang\t2001.1-2001.11\nchart_width=24mm\n") }
      proc { DataReader.read(@filename) }.must_raise TChartError
    end
  end
end
