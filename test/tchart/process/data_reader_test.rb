require_relative '../../test_helper'
require 'stringio'

module TChart
  describe DataReader, "read" do
    before do
      @filename = "_DataReader_read_test.txt"
      @settings, @items, @errors = stub, stub, stub
      @old_stderr, $stderr = $stderr, StringIO.new
    end
    after do
      $stderr = @old_stderr
      File.delete(@filename) if File.exists?(@filename)
    end
    it "returns settings, items, and errors" do
      DataParser.stubs(:parse).returns [ @settings, @items, @errors ]
      File.open(@filename, 'w') { |f| f.puts("C\tlang\t2001.1-2001.11\nchart_width=50\n") }
      DataReader.read(@filename).must_equal [ @settings, @items, @errors ]
    end
  end
end
