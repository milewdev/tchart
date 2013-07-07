module Resume
  module Requirements
    module DSL
      class Requirement
        attr_reader :input
        attr_reader :expected_tex
        attr_reader :expected_errors
    
        # nil input means no input file, blank input means an empty input file
        def given_the_input(input)
          @input = input.unindent
        end
    
        # nil TeX means no output file, blank TeX means an empty output file
        def the_expected_tex_is(expected_tex)
          expected_tex = expected_tex.unindent if expected_tex.kind_of? String
          @expected_tex = expected_tex
        end
    
        # blank errors is the same as no errors, so convert blanks to nil
        def the_expected_errors_are(expected_errors)
          expected_errors = expected_errors.unindent.blank_to_nil if expected_errors.kind_of? String
          @expected_errors = expected_errors
        end
      end
    end
  end
end
