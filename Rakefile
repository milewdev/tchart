require 'rake/testtask'
require 'pathname'
require_relative 'lib/tchart/version'

task :default => [ :test, :req ]
task :install => [ :build ]
task :doc => [ :install, :build_readme ]
task :all => [ :test, :req, :build, :install, :doc ]

Rake::TestTask.new :test do |t|
  t.test_files = FileList['test/**/*_test.rb', 'req/**/*_test.rb']
  t.warning = true
end

desc 'Run requirements tests'
task :req do
  test_files = FileList['req/**/*_req.rb'].map { |fn| "\"#{fn}\"" }.join(", ")
  Rake::FileUtilsExt.verbose(false) do
    ruby "-r ./req/dsl/lib/runner.rb -e 'TChart::Requirements::DSL::Runner.run([#{test_files}])'"
  end
end

# TODO: refactor;
desc 'Generate README.md chart images'
task :build_readme do
  readme = File.open('README.md') { |f| f.read }
  # TODO: use @tchart instead of @generate
  readme.scan( /<!-- @generate (.*?) -->.*?```.*?\n(.*?)```.*?<!-- @end -->/m ) do |fn, spec|
    puts fn
    Dir.chdir('doc/README/src') do
      File.open('drawing.txt', 'w') { |f| f.write(spec) }
    	system "tchart drawing.txt drawing.tikz"
    	system "pdftex -interaction=batchmode drawing.tex > /dev/null"
      system "pdfcrop --margins '30 5 30 10' drawing.pdf cropped.pdf > /dev/null"
      system "gs -q -dQUIET -dSAFER -dBATCH -dNOPAUSE -dNOPROMPT -dMaxBitmap=500000000 -dAlignToPixels=0 -dGridFitTT=2 -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -r100 -sDEVICE=jpeg -dJPEGQ=100 -sOutputFile=../#{Pathname.new(fn).basename} cropped.pdf"
      system "rm drawing.txt drawing.tikz drawing.pdf cropped.pdf drawing.log drawing.pgf"
    end
  end
end

desc 'Build gem'
task :build do
  system "gem build tchart.gemspec"
end

desc 'Install gem locally (does an uninstall first)'
task :install do
  system "gem uninstall -x tchart"
  system "gem install tchart-#{TChart::Version}.gem"
end
