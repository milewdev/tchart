require 'stringio'

require_relative '../../../lib/tchart'

# 'require' all project files except ourselves.
me = File.absolute_path(__FILE__)
Dir.glob(File.dirname(me) + '/**/*.rb') {|fn| require fn if fn != me }

module Kernel
  def requirement(description, &block)
    TChart::Requirements::DSL::Runner.run_requirement(description, &block)
  end
end

module TChart
  module Requirements
    module DSL
      class Runner
        
        Data_filename = "_test_.txt"
        Tex_filename = "_test_.tex"
        
        # Load requirements file(s); each one will then invoke #run_requirement, 
        # via Kernel#requirement (see above), one or more times.
        def self.run(files)
          files.each { |filename| load filename }
        end
        
        def self.run_requirement(description, &block)
          puts description
          if block.nil?
            puts "skip".indent(2)
          else
            requirement = create_requirement(&block)
            return unless requirement_valid?(requirement)
            delete_test_files
            actual_tex, actual_errors = run_tchart_run(requirement)
            Checker.check_output('TeX', requirement.expected_tex, actual_tex)
            Checker.check_output('errors', requirement.expected_errors, actual_errors)
          end
        rescue => e
          $stderr.puts e.message.indent(2)
          $stderr.puts e.backtrace.join("\n    ")
        ensure
          delete_test_files
        end
        
      private
        
        def self.delete_test_files
          [ Data_filename, Tex_filename ].each { |filename| File.delete(filename) if File.exists?(filename) }
        end
        
        def self.create_requirement(&block)
          requirement = Requirement.new
          requirement.instance_eval(&block)
          requirement
        end
        
        def self.requirement_valid?(requirement)
          case
          when requirement.expected_tex.nil? && requirement.expected_errors.nil?
            $stderr.puts "Error: either 'the_expected_tex_is' or 'the_expected_errors_are' must be given, but neither was found.".indent(2)
            false
          when !requirement.expected_tex.nil? && !requirement.expected_errors.nil?
            $stderr.puts "Error: only one of 'the_expected_tex_is' or 'the_expected_errors_are' must be given, but both were found.".indent(2)
            false
          else
            true
          end
        end
        
        def self.run_tchart_run(requirement) # => actual_tex, actual_errors
          prep_input_file(requirement)
          actual_errors = capture_stderr_from { TChart.run([Data_filename, Tex_filename]) }
          actual_tex = retrieve_generated_tex
          [ actual_tex, actual_errors ]
        end
        
        def self.prep_input_file(requirement)
          File.open(Data_filename, "w") { |f| f.puts(requirement.input) } if not requirement.input.nil?
        end
        
        def self.capture_stderr_from(&block) # => String
          old_stderr, $stderr = $stderr, StringIO.new          
          block.call
          $stderr.string.strip.length == 0 ? nil : $stderr.string
        ensure
          $stderr = old_stderr
        end
        
        def self.retrieve_generated_tex # => String
          IO.read(Tex_filename) if File.exists?(Tex_filename)
        end
      end
    end
  end
end
