require "./lib/tchart/version"

Gem::Specification.new do |s|
  s.name                        = "tchart"
  s.version                     = TChart::Version
  s.homepage                    = "https://github.com/milewgit/tchart"
  s.summary                     = "Generate TikZ code to plot date-based data."
  s.description                 = <<-EOS
                                  tchart reads a text file containing date-based data,
                                  for example employment history, and generates TikZ
                                  code to render a chart of the data.  The generated 
                                  TikZ chart can then be embedded in a TeX or LaTeX
                                  document, such as a resume.
                                  EOS
  s.author                      = "Michael Lewandowski"
  s.email                       = "milewgit@gmail.com"
  s.license                     = "MIT"
  s.requirements                = [ "Ruby 2", "A TeX distribution (e.g. tug.org/mactex) to render the generated TikZ chart code." ]
  s.platform                    = Gem::Platform::RUBY
  s.required_ruby_version       = "~> 2"
  s.files                       = Dir[ "lib/**/**", "LICENSE.txt", "README.md", "doc/README/*.jpg" ]
  s.require_paths               = [ "lib" ]
  s.bindir                      = "bin"
  s.executables                 = [ "tchart" ]
  s.add_development_dependency  "mocha", "~> 0"
  s.add_development_dependency  "bundler", "~> 1"
  s.add_development_dependency  "rake", "~> 10"
  s.test_files                  = Dir[ "test/**/*_test.rb" ]
end
