require_relative '../test_helper'

module TChart
  describe Main do
    before do
      @old_stderr, $stderr = $stderr, StringIO.new
    end
    after do
      $stderr = @old_stderr
    end
    it "writes only the message (not the stack trace) to $stderr of TChartErrors" do
      TChart::Main.run([])
      $stderr.string.must_equal "Usage: tchart-ruby data_file tex_file\n"
    end
    it "writes both the message and the stack trace to $stderr of any exception that is not a TChartError" do
      bad_argument = Date.new
      TChart::Main.run(bad_argument)
      $stderr.string.must_match %r{undefined method `length'}
      $stderr.string.must_match %r{lib/tchart/process/command_line_parser\.rb:\d+:in `parse'}
    end
  end
end
