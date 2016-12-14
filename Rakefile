require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test:."
  t.test_files = FileList['test/**/*_test.rb']
end

task :default => :test

task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task['test'].execute
end

task :build do
  cmd="gem build scoped_hash.gemspec"
  exec cmd
end
