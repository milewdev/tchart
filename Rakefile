require 'rake/testtask'
require_relative 'lib/tchart/version'

task :default => [ :test, :req ]
task :doc => [ :build_readme ]
task :all => [ :test, :req, :doc, :build, :install ]

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

desc 'Generate README.md and its images'
task :build_readme do
  Dir.chdir('doc/README/src') do
    system './build'
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
