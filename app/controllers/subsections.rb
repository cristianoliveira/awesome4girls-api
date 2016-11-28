# frozen_string_literal: true

# Responsible expose subsection endpoints
#
class SubsectionsController < Sinatra::Base
  register Sinatra::BasicAuth
  register Sinatra::ErrorsHandler
  register Sinatra::JsonApi
  helpers Sinatra::Param

  before do
    content_type :json
  end

  # GET /subsections/1
  get '/:id' do
    subsection = Subsection.find(params[:id])
    jsonapi(subsection, is_collection: false)
  end

  # GET /subsections
  get '/' do
    subsections = Subsection.all
    jsonapi(subsections, is_collection: true)
  end

  # GET /subsections/1/projects
  get '/:id/projects' do
    section = Subsection.find(params[:id])
    jsonapi(section.projects, is_collection: true)
  end

  # POST /subsections?title=meetup&description=somedescription&section=1
  post '/' do
    restricted_to!(User::ROLE_USER) { |name| User.find_by_name(name) }

    param :section, Integer, required: true
    param :title, String, required: true
    param :description, String

    subsection = Subsection.new(title: params[:title],
                                description: params[:description],
                                section_id: params[:section])

    if subsection.save
      jsonapi(subsection, is_collection: false)
    else
      halt 400, json_errors(subsection.errors)
    end
  end

  # PUT /subsections/1?title=meetup&description=somedescription
  put '/:id' do
    restricted_to!(User::ROLE_USER) { |name| User.find_by_name(name) }

    param :title, String, required: true
    param :description, String

    subsection = Subsection.find(params[:id])
    subsection.update_attributes(title: params[:title],
                                 description: params[:description])

    if subsection.save
      json(message: 'Subsection updated.')
    else
      halt 400, json_errors(subsection.errors)
    end
  end

  # DELETE /subsections/1
  delete '/:id' do
    restricted_to!(User::ROLE_USER) { |name| User.find_by_name(name) }

    subsection = Subsection.find(params[:id])

    if subsection.destroy
      json(message: 'Subsection deleted.')
    else
      halt 400, json_errors(subsection.errors)
    end
  end
end
