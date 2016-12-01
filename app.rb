# frozen_string_literal: true
require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/json'
require 'sinatra/param'

require 'digest/md5'
require 'json'
require 'jsonapi-serializers'

Dir.glob('./app/{extensions,serializers,models,controllers}/*.rb').each do |f|
  require f
end

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
