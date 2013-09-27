require_relative 'test_helper'

module TChart
  describe TChart do
    
    before do
      @argv = ["smoke_test.txt", "smoke_test.tex"]
      File.open(@argv[0], 'w') {|f| f.puts("skill \t style \t 2001-2005\n---")}
    end
    
    after do
      @argv.each { |filename| File.delete(filename) if File.exist?(filename) }
    end
    
    it "is silent when everything runs successfully" do
      proc { TChart.run(@argv) }.must_be_silent
    end
    
    it "writes errors and aborts if command line argument errors are found" do
      CommandLineParser.stubs(:parse).returns [ stub, [ 'an error'] ]
      proc do
        proc do
          TChart.run(@argv)
        end.must_raise SystemExit
      end.must_output nil, "an error\n"
    end
    
    it "writes errors and aborts if parsing errors are found" do
      DataReader.stubs(:read).returns [ stub, stub, [ 'an error' ] ]
      proc do
        proc do
          TChart.run(@argv)
        end.must_raise SystemExit
      end.must_output nil, "an error\n"
    end
    
    it "writes errors and aborts if layout errors are found" do
      LayoutBuilder.stubs(:build).returns [ stub, [ 'an error' ] ]
      proc do
        proc do
          TChart.run(@argv)
        end.must_raise SystemExit
      end.must_output nil, "an error\n"
    end
  
  end
end
