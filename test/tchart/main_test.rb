require_relative '../test_helper'

module TChart
  describe Main do
    before do
      @argv = ["smoke_test.txt", "smoke_test.tex"]
      File.open(@argv[0], 'w') {|f| f.puts("skill \t style \t 2001-2005\n---")}
      @old_stderr, $stderr = $stderr, StringIO.new
    end
    after do
      $stderr = @old_stderr
      @argv.each { |filename| File.delete(filename) if File.exist?(filename) }
    end
    it "works" do
      TChart::Main.run(@argv)
      $stderr.string.must_equal ""
    end
    it "writes only the message (not the stack trace) to $stderr of TChartErrors" do
      TChart::Main.run([])
      $stderr.string.must_equal "Usage: tchart input-data-filename output-tikz-filename\n"
    end
    it "writes both the message and the stack trace to $stderr of any exception that is not a TChartError" do
      bad_argument = Date.new
      TChart::Main.run(bad_argument)
      $stderr.string.must_match %r{undefined method `length'}
      $stderr.string.must_match %r{lib/tchart/process/command_line_parser\.rb:\d+:in `parse'}
    end
    it "writes errors if parsing errors are found" do
      DataReader.stubs(:read).returns [ stub, stub, [ 'an error' ] ]
      TChart::Main.run(@argv)
      $stderr.string.must_include 'an error'
    end
    it "writes errors if layout (settings) errors are found" do
      Layout.stubs(:check_layout).returns [ 'an error' ]
      TChart::Main.run(@argv)
      $stderr.string.must_include 'an error'
    end
  end
end
