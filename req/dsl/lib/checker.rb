module TChart
  module Requirements
    module DSL
      class Checker
        def self.check_output(output_description, expected, actual)
          case
          when unexpected_output(output_description, expected, actual)
          when missing_output(output_description, expected, actual)
          when match_output(output_description, expected, actual)
          when compare_output(output_description, expected, actual)
          end
        end
        
        def self.unexpected_output(output_description, expected, actual) # => true if processed, false if not
          return false unless expected.nil? and not actual.nil?
          $stderr.puts "Error: unexpected #{output_description} generated:".indent(2)
          $stderr.puts actual.indent(4)
          true
        end
        
        def self.missing_output(output_description, expected, actual) # => true if processed, false if not
          return false unless not expected.nil? and actual.nil?
          $stderr.puts "Error: expected #{output_description} but none generated.  Expected:".indent(2)
          $stderr.puts expected.indent(4)
          true
        end
        
        def self.match_output(output_description, expected, actual) # => true if processed, false if not
          return false unless expected.kind_of? Regexp
          print_output_doesnt_match(output_description, expected, actual) if ! expected.match(actual)
          true
        end
        
        def self.compare_output(output_description, expected, actual) # => true
          cleaned_expected = expected || ""
          cleaned_actual = actual || ""
          cleaned_expected = escape_regex_special_chars(cleaned_expected.gsub(/^[ \t]+/, '').gsub(/[ \t]+$/, '').gsub(/[ \t]+/, ' ').gsub(/\n+/, "\n"))
          cleaned_actual = cleaned_actual.gsub(/^[ \t]+/, '').gsub(/[ \t]+$/, '').gsub(/[ \t]+/, ' ').gsub(/\n+/, "\n")
          print_output_doesnt_match(output_description, expected, actual) if ! cleaned_actual.match(cleaned_expected)
          true
        end
        
        def self.escape_regex_special_chars(text)
          temp_pattern = '@REGEX@GOES@HERE@'
          regex = %r{\/[^\/]*\/}
          matches = text.scan(regex)
          text = text.gsub(regex, temp_pattern)
          text = Regexp.escape(text)
          i = -1
          text.gsub temp_pattern do
            i += 1
            matches[i].gsub(/^\//, '').gsub(/\/$/, '')
          end
        end
        
        # Note that expected and actual can each be several lines.
        def self.print_output_doesnt_match(output_description, expected, actual)
          expected = expected.inspect if expected.kind_of? Regexp
          $stderr.puts "Error: #{output_description} output does not match.  Expected:".indent(2)
          $stderr.puts expected.indent(4)
          $stderr.puts "Actual:".indent(2)
          $stderr.puts actual.indent(4)
        end
      end
    end
  end
end
