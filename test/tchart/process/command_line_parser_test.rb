require_relative '../../test_helper'

module TChart
  describe CommandLineParser, "parse" do
    it "returns CommandLineArgs with appropriate attributes parsed from the command line" do
      File.expects(:exists?).with('input_filename').returns(true)
      File.expects(:file?).with('input_filename').returns(true)
      args, _ = CommandLineParser.parse( [ 'input_filename', 'tex_filename' ] )
      args.data_filename.must_equal 'input_filename'
      args.tex_filename.must_equal 'tex_filename'
    end
    it "returns an error if there are fewer than two arguments" do
      _, errors = CommandLineParser.parse( [ 'arg1' ] )
      errors.must_include "Usage: tchart input-data-filename output-tikz-filename"
    end
    it "returns an error if there are more than two arguments" do
      _, errors = CommandLineParser.parse( [ 'arg1', 'arg2', 'arg3' ] )
      errors.must_include "Usage: tchart input-data-filename output-tikz-filename"
    end
    it "returns an error if the input and output file names are the same" do
      File.expects(:exists?).with('arg1').returns(true)
      File.expects(:file?).with('arg1').returns(true)
      _, errors = CommandLineParser.parse( [ 'arg1', './arg1' ] )
      errors.must_include "Error: input \"arg1\" and output \"./arg1\" refer to the same file."
    end
    it "returns an error if the input data file does not exist" do
      File.expects(:exists?).with('does_not_exist').returns(false)
      _, errors = CommandLineParser.parse( [ 'does_not_exist', 'arg2' ] )
      errors.must_include "Error: input data file \"does_not_exist\" not found."
    end
    it "returns an error if the input data file is not a file" do
      File.expects(:exists?).with('input_filename').returns(true)
      File.expects(:file?).with('input_filename').returns(false)
      _, errors = CommandLineParser.parse( [ 'input_filename', 'arg2' ] )
      errors.must_include "Error: input data file \"input_filename\" is not a file."
    end
    it "returns an error if the output data file exists and is not a file" do
      skip
    end
  end
end
