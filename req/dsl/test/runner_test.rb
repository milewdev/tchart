require_relative 'test_helper'

module TChart
  module Requirements
    module DSL
      describe Runner, "run" do
        it "calls kernel#load for each file passed to it" do
          files = [ "file1.txt", "file2.txt", "file3.txt" ]
          files.each { |filename| Runner.expects(:load).with(filename) }
          Runner.run(files)
        end
      end
      
      describe Runner, "run_requirement" do
        before do
          [ "_test_.txt", "_test_.tex" ].each { |filename| File.delete(filename) if File.exists?(filename) }
          @old_stdout, $stdout = $stdout, StringIO.new
          @old_stderr, $stderr = $stderr, StringIO.new
        end
        after do
          $stdout = @old_stdout
          $stderr = @old_stderr
          [ "_test_.txt", "_test_.tex" ].each { |filename| File.delete(filename) if File.exists?(filename) }
        end
        it "passes two file name arguments to Resume::Main.run" do
          TChart::Main.expects(:run).with(["_test_.txt", "_test_.tex"])
          Runner.run_requirement "description" do
            the_expected_errors_are "some errors"
          end
        end
        it "does not leave any test files lying around" do
          File.exists?('_test_.txt').must_equal false
          File.exists?('_test_.tex').must_equal false
        end
        it "creates the input file if input is supplied" do
          File.expects(:open).with("_test_.txt", "w")
          Runner.run_requirement "description" do
            given_the_input "item"
            the_expected_errors_are "some errors"
          end
        end
        it "creates the input file if empty input is supplied" do
          File.expects(:open).with("_test_.txt", "w")
          Runner.run_requirement "description" do
            given_the_input ""
            the_expected_errors_are "some errors"
          end
        end
        it "does not create an input file if no input is supplied" do
          File.expects(:open).never
          Runner.run_requirement "description" do
            the_expected_errors_are "some errors"
          end
        end
        it "does not create an input file if no block is supplied" do
          File.expects(:open).never
          Runner.run_requirement "description"
        end
        it "prints the requirement description if a block is supplied" do
          Runner.run_requirement "description" do
            the_expected_errors_are "some errors"
          end
          $stdout.string.must_equal "description\n"
        end
        it "prints the requirement description if no block is supplied" do
          Runner.run_requirement "description"
          $stdout.string.must_match "description"
        end
        it "invokes Resume.run when a block is supplied" do
          TChart::Main.expects(:run)
          Runner.run_requirement "description" do
            the_expected_errors_are "some errors"
          end
        end
        it "does not invoke Resume.run when no block is supplied" do
          TChart.expects(:run).never
          Runner.run_requirement "description"
        end
        it "prints 'skip' when no block is supplied" do
          Runner.run_requirement "description"
          $stdout.string.must_equal "description\n  skip\n"
        end
        it "does not complain if the supplied TeX matches the actual TeX" do
          Runner.run_requirement "description" do
            given_the_input "item"
            the_expected_tex_is %r{\\tikzpicture}
          end
          $stderr.string.must_equal ""
        end
        it "prints a 'TeX does not match' error if the supplied TeX does not match the actual TeX" do
          Runner.run_requirement "description" do
            given_the_input "item"
            the_expected_tex_is "anything"
          end
          $stderr.string.must_match <<-'EOS'.gsub(/^ {10}/, '')
            Error: TeX output does not match.  Expected:
              anything
            Actual:
              \tikzpicture
          EOS
        end
        it "prints an 'unexpected TeX generated' error if TeX was generated but none was expected" do
          Runner.run_requirement "description" do
            given_the_input "item"
            the_expected_errors_are "some errors"
          end
          $stderr.string.must_match "Error: unexpected TeX generated"
        end
        it "prints an 'expected TeX but none generated' error if TeX was expected but none was generated" do
          Runner.run_requirement "description" do
            given_the_input ""
            the_expected_tex_is "anything"
          end
          $stderr.string.must_match <<-'EOS'.gsub(/^ {10}/, '')
            Error: expected TeX but none generated.  Expected:
              anything
          EOS
        end
        it "does not complain if the supplied errors match the actual errors" do
          Runner.run_requirement "description" do
            given_the_input ""
            the_expected_errors_are <<-EOS
              _test_.txt, 1: no items found
            EOS
          end
          $stderr.string.must_equal ""
        end
        it "allows errors to be expressed as regexes" do
          Runner.run_requirement "description" do
            given_the_input ""
            the_expected_errors_are %r{_test_.txt, 1: no items found}
          end
          $stderr.string.must_equal ""
        end
        it "prints an 'errors output does not match' error if the supplied errors do not match the actual errors" do
          Runner.run_requirement "description" do
            given_the_input "chart_width = 42"
            the_expected_errors_are "abc"
          end
          $stderr.string.must_match <<-'EOS'.gsub(/^ {10}/, '')
            Error: errors output does not match.  Expected:
              abc
            Actual:
              _test_.txt, 1: no items found
          EOS
        end
        it "prints an 'unexpected errors generated' error if unexpected errors were generated" do
          Runner.run_requirement "description" do
            given_the_input ""
            the_expected_tex_is "some TeX"
          end
          $stderr.string.must_match <<-'EOS'.gsub(/^ {10}/, '')
            Error: unexpected errors generated:
              _test_.txt, 1: no items found
          EOS
        end
        it "prints an 'expected errors but none generated' error if errors were expected but none were generated" do
          Runner.run_requirement "description" do
            given_the_input "item"
            the_expected_errors_are "anything"
          end
          $stderr.string.must_match <<-'EOS'.gsub(/^ {10}/, '')
            Error: expected errors but none generated.  Expected:
              anything
          EOS
        end
        it "empty errors are treated as no errors" do
          Runner.run_requirement "description" do
            given_the_input "chart_width=42"
            the_expected_errors_are ""
          end
          $stderr.string.must_match "Error: either 'the_expected_tex_is' or 'the_expected_errors_are' must be given, but neither was found."
        end
        it "blank errors are treated as no errors" do
          Runner.run_requirement "description" do
            given_the_input "chart_width=42"
            the_expected_errors_are "  "
          end
          $stderr.string.must_match "Error: either 'the_expected_tex_is' or 'the_expected_errors_are' must be given, but neither was found."
        end
        it "prints an error is neither the_expected_tex_is or the_expected_errors_are are specified" do
          Runner.run_requirement "description" do
            # empty
          end
          $stderr.string.must_match "Error: either 'the_expected_tex_is' or 'the_expected_errors_are' must be given, but neither was found."
        end
        it "does not invoke Resume.run if neither the_expected_tex_is or the_expected_errors_are are given" do
          TChart.expects(:run).never
          Runner.run_requirement "description" do
            # empty
          end
        end
        it "prints an error is both the_expected_tex_is and the_expected_errors_are are specified" do
          Runner.run_requirement "description" do
            the_expected_tex_is "some TeX"
            the_expected_errors_are "some errors"
          end
          $stderr.string.must_match "Error: only one of 'the_expected_tex_is' or 'the_expected_errors_are' must be given, but both were found."
        end
        it "does not invoke Resume.run if both the_expected_tex_is and the_expected_errors_are are given" do
          TChart.expects(:run).never
          Runner.run_requirement "description" do
            the_expected_tex_is "some TeX"
            the_expected_errors_are "some errors"
          end
        end
      end
    end
  end
end
