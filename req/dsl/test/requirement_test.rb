require_relative 'test_helper'

module TChart  
  module Requirements
    module DSL
      describe Requirement, "given_the_input" do
        it "saves its argument" do
          input = 'some input'
          req = Requirement.new
          req.given_the_input(input)
          req.input.must_equal input
        end
        it "unindents all lines" do
          input = "  a\n    b"
          req = Requirement.new
          req.given_the_input(input)
          req.input.must_equal "a\n  b"
        end
      end
  
      describe Requirement, "the_expected_tex_is" do
        it "saves its argument" do
          tex = 'some tex'
          req = Requirement.new
          req.the_expected_tex_is(tex)
          req.expected_tex.must_equal tex
        end
        it "unindents all lines" do
          input = "  a\n    b"
          req = Requirement.new
          req.the_expected_tex_is(input)
          req.expected_tex.must_equal "a\n  b"
        end
      end
  
      describe Requirement, "the_expected_errors" do
        it "saves its argument" do
          errors = 'some errors'
          req = Requirement.new
          req.the_expected_errors_are(errors)
          req.expected_errors.must_equal errors
        end
        it "converts the empty string to nil" do
          req = Requirement.new
          req.the_expected_errors_are("")
          req.expected_errors.must_be_nil
        end
        it "converts a blank string to nil" do
          req = Requirement.new
          req.the_expected_errors_are("   ")
          req.expected_errors.must_be_nil
        end
        it "unindents all lines" do
          input = "  a\n    b"
          req = Requirement.new
          req.the_expected_errors_are(input)
          req.expected_errors.must_equal "a\n  b"
        end
      end
    end
  end
end
