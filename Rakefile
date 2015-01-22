require "bundler/gem_tasks"

begin
  require 'rspec/core/rake_task'

  desc 'Run specs'
  RSpec::Core::RakeTask.new(:spec) do |r|
    r.verbose = false
  end
rescue LoadError
  puts 'RSpec not available.'
end


