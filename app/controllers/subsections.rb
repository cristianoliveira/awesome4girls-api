# frozen_string_literal: true

# Responsible for implementing subsection endpoints
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
    restricted_to_users!

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
    restricted_to_users!

    section = Section.find(params[:sectionid])
    subsection = section.subsections.find(params[:id])

    if subsection.destroy
      json(message: 'Subsection deleted.')
    else
      halt 400, json(error: section.errors.full_messages)
    end
  end

  private

  def restricted_to_users!
    authorize!('users') do |name, pass|
      user = User.find_by_name(name)
      user && user.auth?(pass) && user.is_a?(User::ROLE_USER)
    end
  end
end
