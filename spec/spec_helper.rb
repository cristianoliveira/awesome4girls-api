ENV['RACK_ENV'] ||= 'test'

# Require API Application
require File.join(File.dirname(__FILE__),'..', 'app')

# Rack Test
require 'rack/test'

require 'factory_girl'

require "json"

FactoryGirl.definition_file_paths = [ File.join(File.dirname(__FILE__), 'factories') ]

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  config.include Rack::Test::Methods
end

# Application
def app
  Rack::URLMap.new App.routes
end
