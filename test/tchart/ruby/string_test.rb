require_relative '../../test_helper'

describe String, "indent" do
  it "indents each line by the specified number of spaces" do
    "abc\ndef\n".indent(2).must_equal "  abc\n  def\n"
  end
  it "does not indent empty lines" do
    "abc\n\ndef\n".indent(2).must_equal "  abc\n\n  def\n"
  end
  it "does not indent blank lines" do
    "abc\n  \ndef\n".indent(2).must_equal "  abc\n  \n  def\n"
  end
  it "indents lines that are already indented" do
    " abc\ndef\n".indent(2).must_equal "   abc\n  def\n"
  end
  it "indents lines that are not terminated by a newline" do
    "abc\ndef".indent(2).must_equal "  abc\n  def"
  end
end

describe String, "unindent" do
  it "unindents the lines by the amount the line with the least indentation is indented" do
    " a\n  b\n".unindent.must_equal "a\n b\n"
  end
  it "returns all lines unindented if they are all indented by the same amount" do
    " a\n b\n".unindent.must_equal "a\nb\n"
  end
  it "returns lines unaltered if none of them are indented" do
    "a\nb\n".unindent.must_equal "a\nb\n"
  end
  it "returns the lines unaltered if at least on of the them is not indented" do
    "a\n b\n".unindent.must_equal "a\n b\n"
  end
  it "returns a string unaltered if it is not indented" do
    "a".unindent.must_equal "a"
  end
  it "returns a line unaltered if it is not indented" do
    "a\n".unindent.must_equal "a\n"
  end
  it "ignores blank lines" do
    " \n  a\n   b".unindent.must_equal " \na\n b"
  end
  it "returns an empty string if the input is an empty string" do
    "".unindent.must_equal ""
  end
  it "returns a blank string if the input is a blank string" do
    " ".unindent.must_equal " "
  end
  it "returns an empty line if the input is an empty line" do
    "\n".unindent.must_equal "\n"
  end
  it "returns a blank line if the input is a blank line" do
    " \n".unindent.must_equal " \n"
  end
  it "raises an exception if the line starts with a tab" do
    proc { "\ta".unindent }.must_raise Exception
  end
  it "raises an exception if the line contains one or more tabs in the leading whitespace" do
    proc { " \ta".unindent }.must_raise Exception
  end
  it "does not raise an exception if the line contains tabs but they are not in the leading whitespace" do
    " a\t".unindent
  end
end
