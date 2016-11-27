require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require "sinatra/json"
require "sinatra/param"

require 'digest/md5'

require_relative 'app/extensions/init'
require_relative 'app/models/init'
require_relative 'app/controllers/init'

class App
  # Define Routes
  def self.routes
    {
      '/users' => UsersController,
    }
  end

end
