# frozen_string_literal: true
require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/json'
require 'sinatra/param'

require 'digest/md5'

require_relative 'app/extensions/init'
require_relative 'app/models/init'
require_relative 'app/controllers/init'

# The app routes.
#
class App
  def self.routes
    {
      '/users' => UsersController,
      '/sections' => SectionsController,
      '/section' => SubsectionsController,
      '/projects' => ProjectsController
    }
  end
end
