require 'minitest/autorun'
require 'minitest/focus'
require 'mocha/setup'         # must be after require 'minitest/autorun'

me = File.absolute_path(__FILE__)
Dir.glob(File.dirname(me) + '/../lib/**/*.rb') {|fn| require fn }

def capture_stderr
  old_stderr, $stderr = $stderr, StringIO.new
  yield if block_given?
  $stderr.string
ensure
  $stderr = old_stderr
end

alias :ignore_stderr :capture_stderr
