require 'bundler/gem_helper'
# require 'rspec/core/rake_task'
require './texter_app'
require 'sinatra/activerecord/rake'

# desc 'Run all specs'
# RSpec::Core::RakeTask.new(:spec) do |t|
#   t.rspec_opts = %w(--color)
#   t.verbose = false
# end

begin 
  require 'rspec/core/rake_task'
  desc 'Run all specs'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = %w(--color)
    t.verbose = false
  end
rescue LoadError
end

task default: :spec

desc "Pull bus stop information from cta"
task :pull_bus_stops do
  CtaApiIntegration.new.extract_all_bus_stops
end