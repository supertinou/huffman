require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "./tasks/benchmark_task"
require "./tasks/generate_files_for_tests.rb"


RSpec::Core::RakeTask.new

task :default => :spec
task :test => :spec


desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r huffman.rb"
end
