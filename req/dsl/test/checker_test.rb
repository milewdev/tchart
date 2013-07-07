require_relative 'test_helper'

module TChart
  module Requirements
    module DSL
      describe Checker, "unexpected_output" do
        it "returns false when there is no output and none was expected" do
          Checker.unexpected_output('DESCRIPTION', nil, nil).must_equal false
        end
        it "returns true when there is output but none was expected" do
          ignore_stderr do
            Checker.unexpected_output('DESCRIPTION', nil, 'ACTUAL').must_equal true
          end
        end
        it "writes output to $stderr when there is output but none was expected" do
          capture_stderr do
            Checker.unexpected_output('DESCRIPTION', nil, 'ACTUAL')
          end.must_equal <<-EOS.unindent.indent(2)
            Error: unexpected DESCRIPTION generated:
              ACTUAL
          EOS
        end
      end
      
      describe Checker, "missing_output" do
        it "returns false when there is output and output was expected" do
          Checker.missing_output('description', 'EXPECTED', 'ACTUAL').must_equal false
        end
        it "returns true when there is no output but output was expected" do
          ignore_stderr do
            Checker.missing_output('description', 'EXPECTED', nil).must_equal true
          end
        end
        it "writes output to $stderr when there is no output but output was expected" do
          capture_stderr do
            Checker.missing_output('DESCRIPTION', 'EXPECTED', nil)
          end.must_equal <<-EOS.unindent.indent(2)
            Error: expected DESCRIPTION but none generated.  Expected:
              EXPECTED
          EOS
        end
      end
      
      describe Checker, "match_output" do
        it "returns false when the expected output argument is not a regexp" do
          Checker.match_output('description', 'EXPECTED', 'ACTUAL').must_equal false
        end
        it "returns true when the expected output argument is a regexp" do
          ignore_stderr do
            Checker.match_output('description', /[0-9]/, 'ACTUAL').must_equal true
          end
        end
        it "writes nothing to $stderr when the actual output matches the regexp" do
          capture_stderr do
            Checker.match_output('DESCRIPTION', /[A-Z]/, 'ACTUAL')
          end.must_equal ""
        end
        it "writes output to $stderr when the actual output does not match the regexp" do
          capture_stderr do
            Checker.match_output('DESCRIPTION', /[0-9]/, 'ACTUAL')
          end.must_match %r{Error}
        end
      end
      
      describe Checker, "compare_output" do
        it "always returns true" do
          ignore_stderr do
            Checker.compare_output('description', 'EXPECTED', 'ACTUAL').must_equal true
          end
        end
        it "writes nothing to $stderr when the expected and actual outputs match" do
          capture_stderr do
            Checker.compare_output('DESCRIPTION', 'MATCH', 'MATCH')
          end.must_equal ""
        end
        it "writes output to $stderr when the expected and actual outputs do not match" do
          capture_stderr do
            Checker.compare_output('DESCRIPTION', 'EXPECTED', 'ACTUAL')
          end.must_match %r{Error}
        end
        it "ignores leading spaces/tabs on each line when doing the comparison" do
          capture_stderr do
            Checker.compare_output('DESCRIPTION', "\t a\nb", "a\n\t b")
          end.must_equal ""
        end
        it "ignores trailing spaces/tabs on each line when doing the comparison" do
          capture_stderr do
            Checker.compare_output('DESCRIPTION', "a\nb \t", "a \t\nb")
          end.must_equal ""
        end
        it "treats consecutive spaces as one space when doing the comparison" do
          capture_stderr do
            Checker.compare_output('DESCRIPTION', "a  b c", "a b  c")
          end.must_equal ""
        end
        it "treats one or more consecutive tabs as one space when doing the comparison" do
          capture_stderr do
            Checker.compare_output('DESCRIPTION', "a\tb\t\tc", "a\t\tb\tc")
          end.must_equal ""
        end
        it "treats one or more consecutive newlines as one newline when doing the comparison" do
          capture_stderr do
            Checker.compare_output('DESCRIPTION', "a\n\nb", "a\n\n\nb")
          end.must_equal ""
        end
        it "handles embedded regexes" do
          capture_stderr do
            Checker.compare_output('DESCRIPTION', "a/[0-9]/c", "a2c")
          end.must_equal ""
        end
        it "treats regex special characters as normal characters when not in a regex" do
          capture_stderr do
            Checker.compare_output('DESCRIPTION', "a[0-9]c", "a[0-9]c")
          end.must_equal ""
        end
      end
      
      describe Checker, "escape_regex_special_chars" do
        it "escapes regex special chars that are not in a regex" do
          Checker.escape_regex_special_chars("[](){}.?+* \\").must_equal '\[\]\(\)\{\}\.\?\+\*\ \\\\'
        end
        it "does not change anything within a regex" do
          Checker.escape_regex_special_chars("/[](){}.?+* \\/").must_equal '[](){}.?+* \\'
        end
      end
      
      describe Checker, "print_output_doesnt_match" do
        it "writes output to $stderr" do
          capture_stderr do
            Checker.print_output_doesnt_match('DESCRIPTION', 'EXPECTED', 'ACTUAL')
          end.must_equal <<-EOS.unindent.indent(2)
            Error: DESCRIPTION output does not match.  Expected:
              EXPECTED
            Actual:
              ACTUAL
          EOS
        end
        it "handles expected arguments that are regexps" do
          capture_stderr do
            Checker.print_output_doesnt_match('DESCRIPTION', /[A-Z]/, 'ACTUAL')
          end.must_equal <<-EOS.unindent.indent(2)
            Error: DESCRIPTION output does not match.  Expected:
              /[A-Z]/
            Actual:
              ACTUAL
          EOS
        end
      end
    end
  end
end
