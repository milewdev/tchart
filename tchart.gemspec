require './lib/tchart/version'

Gem::Specification.new do |s|
  s.name                  = "tchart"
  s.summary               = "Generate TeX/TikZ charts."
  s.description           = "Generate TikZ code to draw a chart of date-based data."
  s.license               = "MIT"
  s.requirements          = [ "none" ]
  s.version               = "#{TChart::Version}"
  s.author                = "Michael Lewandowski"
  s.email                 = "milewgit@gmail.com"
  s.homepage              = "https://github.com/milewgit/tchart"
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = ">=1.9"
  s.files                 = Dir[ "lib/**/**", "LICENSE.txt", "README.md" ]
  s.executables           = [ "tchart" ]
  s.test_files            = Dir[ "test/*_test.rb" ]
  s.has_rdoc              = false
end
