# frozen_string_literal: true
require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/json'
require 'sinatra/param'

require 'digest/md5'
require 'json'
require 'jsonapi-serializers'

require 'sidekiq/web'
require 'kramdown'

Dir.glob('./app/workers/*.rb').each { |file| require file }
Dir.glob('./app/components/*.rb').each { |file| require file }
Dir.glob('./app/extensions/*.rb').each { |file| require file }
Dir.glob('./app/serializers/*.rb').each { |file| require file }
Dir.glob('./app/models/*.rb').each { |file| require file }
Dir.glob('./app/controllers/*.rb').each { |file| require file }

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
      '/projects' => ProjectsController,
      '/sync' => SyncController,
      '/workers' => Sidekiq::Web
    }
  end
end
