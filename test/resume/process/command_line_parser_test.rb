require_relative '../../test_helper'

module Resume
  describe CommandLineParser, "parse" do
    it "throws an exception if there are fewer than two arguments" do
      proc { CommandLineParser.parse( [ 'arg1' ] ) }.must_raise ApplicationError
    end
    it "throws an exception if there are more than two arguments" do
      proc { CommandLineParser.parse( [ 'arg1', 'arg2', 'arg3' ] ) }.must_raise ApplicationError
    end
    it "throws an exception if the input and output file names are the same" do
      File.expects(:exists?).with('arg1').returns(true)
      File.expects(:file?).with('arg1').returns(true)
      proc { CommandLineParser.parse( [ 'arg1', './arg1' ] ) }.must_raise ApplicationError
    end
    it "throws an exception if the input data file does not exist" do
      File.expects(:exists?).with('does_not_exist').returns(false)
      proc { CommandLineParser.parse( [ 'does_not_exist', 'arg2' ] ) }.must_raise ApplicationError
    end
    it "throws an exception if the input data file is not a file" do
      File.expects(:exists?).with('input_filename').returns(true)
      File.expects(:file?).with('input_filename').returns(false)
      proc { CommandLineParser.parse( [ 'input_filename', 'arg2' ] ) }.must_raise ApplicationError
    end
    it "saves the arguments" do
      File.expects(:exists?).with('input_filename').returns(true)
      File.expects(:file?).with('input_filename').returns(true)
      args = CommandLineParser.parse( [ 'input_filename', 'tex_filename' ] )
      args.data_filename.must_equal 'input_filename'
      args.tex_filename.must_equal 'tex_filename'
    end
  end
end
