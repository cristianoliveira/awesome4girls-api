# frozen_string_literal: true
require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/json'
require 'sinatra/param'

require 'digest/md5'
require 'json'
require 'jsonapi-serializers'

require_relative 'app/serializers/init'
require_relative 'app/extensions/init'
require_relative 'app/models/init'
require_relative 'app/controllers/init'

# The app routes.
#
class App
  VERSION = '0.0.1'

  def self.routes
    {
      '/' => MainController,
      '/users' => UsersController,
      '/sections' => SectionsController,
      '/subsections' => SubsectionsController,
      '/projects' => ProjectsController
    }
  end
end
