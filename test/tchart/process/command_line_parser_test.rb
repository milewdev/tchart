require_relative '../../test_helper'

module TChart
  describe CommandLineParser, "parse" do
    
    Usage = "Usage: tchart [ --version | --help | input-data-filename output-tikz-filename ]"
    
    it "returns CommandLineArgs with appropriate attributes parsed from the command line" do
      File.expects(:exists?).with('input_filename').returns(true)
      File.expects(:file?).with('input_filename').returns(true)
      File.expects(:exists?).with('output_filename').returns(false)
      args, _ = CommandLineParser.parse( [ 'input_filename', 'output_filename' ] )
      args.data_filename.must_equal 'input_filename'
      args.tex_filename.must_equal 'output_filename'
    end
    
    it "returns an error if there are fewer than two arguments" do
      _, errors = CommandLineParser.parse( [ 'input_filename' ] )
      errors.must_include Usage
    end
    
    it "returns an error if there are more than two arguments" do
      _, errors = CommandLineParser.parse( [ 'input_filename', 'output_filename', 'arg3' ] )
      errors.must_include Usage
    end
    
    it "returns an error if the input and output file names are the same" do
      File.expects(:exists?).with('input_filename').returns(true)
      File.expects(:file?).with('input_filename').returns(true)
      File.expects(:exists?).with('./input_filename').returns(true)
      File.expects(:file?).with('./input_filename').returns(true)
      _, errors = CommandLineParser.parse( [ 'input_filename', './input_filename' ] )
      errors.must_include "Error: input \"input_filename\" and output \"./input_filename\" refer to the same file."
    end
    
    it "returns an error if the input data file does not exist" do
      File.expects(:exists?).with('input_filename').returns(false)
      _, errors = CommandLineParser.parse( [ 'input_filename', 'output_filename' ] )
      errors.must_include "Error: input data file \"input_filename\" not found."
    end
    
    it "returns an error if the input data file is not a file" do
      File.expects(:exists?).with('input_filename').returns(true)
      File.expects(:file?).with('input_filename').returns(false)
      _, errors = CommandLineParser.parse( [ 'input_filename', 'output_filename' ] )
      errors.must_include "Error: input data file \"input_filename\" is not a file."
    end
    
    it "returns an error if the output data file exists and is not a file" do
      File.expects(:exists?).with('input_filename').returns(true)
      File.expects(:file?).with('input_filename').returns(true)
      File.expects(:exists?).with('output_filename').returns(true)
      File.expects(:file?).with('output_filename').returns(false)
      _, errors = CommandLineParser.parse( [ 'input_filename', 'output_filename' ] )
      errors.must_include "Error: existing output data file \"output_filename\" is not a file."
    end
    
    it "returns an error containing the version if the -v option is specified" do
      _, errors = CommandLineParser.parse( [ "-v" ] )
      errors.must_include TChart::Version
    end
    
    it "returns an error containing the version if the --version option is specified" do
      _, errors = CommandLineParser.parse( [ "--version" ] )
      errors.must_include TChart::Version
    end
    
    it "other arguments are ignored if -v is specified" do
      _, errors = CommandLineParser.parse( [ "-v", "input_filename", "output_filename" ] )
      errors.must_include TChart::Version
    end
    
    it "returns an error containing usage if the -h option is specified" do
      _, errors = CommandLineParser.parse( [ "-h" ] )
      errors.must_include Usage
    end
    
    it "returns an error containing usage if the --help option is specified" do
      _, errors = CommandLineParser.parse( [ "--help" ] )
      errors.must_include Usage
    end
    
    it "returns an error if an unknown option is specified" do
      _, errors = CommandLineParser.parse( [ "-a" ] )
      errors.must_include Usage
    end

  end
end
