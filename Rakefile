
# frozen_string_literal: true
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

task :rubocop do
  begin
    require 'rubocop/rake_task'
    RuboCop::RakeTask.new
  rescue LoadError
  end
end

task default: :test
task test: ['db:test:prepare', :spec]

namespace :db do
  task :load_config do
    require_relative 'app'
  end
end
