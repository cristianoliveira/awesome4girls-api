# frozen_string_literal: true

require 'sinatra/activerecord'
require_relative 'app'

run Rack::URLMap.new App.routes
