require_relative 'test_helper'

describe String, "blank_to_nil" do
  it "returns nil if given an empty string" do
    "".blank_to_nil.must_be_nil
  end
  it "returns nil if given a blank string" do
    "  ".blank_to_nil.must_be_nil
  end
  it "returns the argument if it is not blank or empty" do
    " a ".blank_to_nil.must_equal " a "
  end
end
