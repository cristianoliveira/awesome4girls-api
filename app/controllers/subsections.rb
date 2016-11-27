# frozen_string_literal: true

# Responsible expose subsection endpoints
#
class SubsectionsController < Sinatra::Base
  register Sinatra::BasicAuth
  register Sinatra::ErrorsHandler
  helpers Sinatra::Param

  before do
    content_type :json
  end

  # GET /section/1/subsections/1
  get '/:sectionid/subsections/:id' do
    section = Section.find(params[:sectionid])
    subsection = section.subsections.find(params[:id])
    json(type: :subsection, data: subsection)
  end

  # GET /section/1/subsections
  get '/:sectionid/subsections' do
    json Section.find(params[:sectionid]).subsections
  end

  # POST /section/1/subsections?title=meetup&description=somedescription
  post '/:sectionid/subsections' do
    restricted_to!(User::ROLE_USER) { |name| User.find_by_name(name) }

    param :title, String, required: true
    param :description, String

    section = Section.find(params[:sectionid])
    subsection = section.subsections.new(title: params[:title],
                                         description: params[:description])

    if subsection.save
      json(message: 'Subsection created.')
    else
      halt 400, json(error: section.errors.full_messages)
    end
  end

  # DELETE /section/1/subsections/1
  delete '/:sectionid/subsections/:id' do
    restricted_to!(User::ROLE_USER) { |name| User.find_by_name(name) }

    section = Section.find(params[:sectionid])
    subsection = section.subsections.find(params[:id])

    if subsection.destroy
      json(message: 'Subsection deleted.')
    else
      halt 400, json(error: section.errors.full_messages)
    end
  end
end
