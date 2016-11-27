# frozen_string_literal: true

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
    json({ type: :section, data: section })
  end

  # GET /sections
  get '/' do
    json Section.all()
  end

  # POST /sections?title=meetup&description=somedescription
  post '/' do
    restricted_to_users!
    param :title, String, required: true
    param :description, String

    section = Section.new(params)

    if section.save
      json({ message: "section created."})
    else
      halt 400, json({ errors: section.errors.full_messages })
    end
  end

  # DELETE /sections/1
  delete '/:id' do
    restricted_to_users!
    section = Section.find(params[:id])

    if section.destroy
      json({ message: "section deleted."})
    else
      halt 400, json({ errors: section.errors.full_messages })
    end
  end

  private
  def restricted_to_users!
    authorize!("users") { |name, pass|
      user = User.find_by_name(name)
      user and user.auth?(pass) and user.is_a?(User::ROLE_USER)
    }
  end
end
