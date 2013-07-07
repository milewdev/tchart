require 'rake/testtask'
require_relative 'lib/resume/version'

task :default => [ :test, :req ]
task :all => [ :test, :req, :build, :install ]

Rake::TestTask.new :test do |t|
  t.test_files = FileList['test/**/*_test.rb', 'req/**/*_test.rb']
  t.warning = true
end

desc 'Run requirements tests'
task :req do
  test_files = FileList['req/**/*_req.rb'].map { |fn| "\"#{fn}\"" }.join(", ")
  Rake::FileUtilsExt.verbose(false) do
    ruby "-r ./req/dsl/lib/runner.rb -e 'Resume::Requirements::DSL::Runner.run([#{test_files}])'"
  end
end

desc 'Build gem'
task :build do
  system "gem build resume.gemspec"
end

desc 'Install gem locally (does an uninstall first)'
task :install do
  system "gem uninstall -x resume"
  system "gem install resume-#{Resume::Version}.gem"
end
