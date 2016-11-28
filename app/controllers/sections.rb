# frozen_string_literal: true

# Responsible expose subsection endpoints
#
class SectionsController < Sinatra::Base
  register Sinatra::BasicAuth
  register Sinatra::ErrorsHandler
  helpers Sinatra::Param

  before do
    content_type :json
  end

  # GET /sections/1
  get '/:id' do
    section = Section.find(params[:id])
    json(type: :section, data: section)
  end

  # GET /sections
  get '/' do
    json Section.all
  end

  # POST /sections?title=meetup&description=somedescription
  post '/' do
    restricted_to!(User::ROLE_USER) { |name| User.find_by_name(name) }
    param :title, String, required: true
    param :description, String

    section = Section.new(params)

    if section.save
      json(message: 'section created.')
    else
      halt 400, json(errors: section.errors.full_messages)
    end
  end

  # PUT /sections/:id?title=meetup&description=somedescription
  put '/:id' do
    restricted_to!(User::ROLE_USER) { |name| User.find_by_name(name) }
    param :title, String, required: true
    param :description, String

    section = Section.find(params[:id])
    section.update_attributes(title: params[:title],
                              description: params[:description])

    if section.save
      json(message: 'section updated.')
    else
      halt 400, json(errors: section.errors.full_messages)
    end
  end

  # DELETE /sections/1
  delete '/:id' do
    restricted_to!(User::ROLE_USER) { |name| User.find_by_name(name) }
    section = Section.find(params[:id])

    if section.destroy
      json(message: 'section deleted.')
    else
      halt 400, json(errors: section.errors.full_messages)
    end
  end
end
