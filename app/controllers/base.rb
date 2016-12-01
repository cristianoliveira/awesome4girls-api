# frozen_string_literal: true

# This the base controller for the api.
# If the route responds Json it should inherit from it.
#
class ApiController < Sinatra::Base
  register Sinatra::ErrorsHandler
  helpers Sinatra::BasicAuth
  helpers Sinatra::JsonApi
  helpers Sinatra::Param

  before do
    content_type :json
  end
end