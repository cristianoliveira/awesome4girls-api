# frozen_string_literal: true

class ProjectsController < Sinatra::Base
  register Sinatra::BasicAuth
  register Sinatra::ErrorsHandler
  helpers Sinatra::Param

  before do
    content_type :json
  end

  # GET /projects/1
  get '/:id' do
    project = Project.find(params[:id])
    json({ type: :project, data: project })
  end

  # GET projects
  get '/' do
    json Project.all()
  end

  # POST /projects?title=meetup&description=somedescription&lang=pt
  post '/' do
    restricted_to_users!
    param :title, String, required: true
    param :description, String, required: true
    param :subsection, Integer, required: true

    subsection = Subsection.find(params[:subsection])
    project = subsection.projects.new(title: params[:title],
                          description: params[:description],
                          subsection: subsection)

    if project.save
      json({ message: "project created."})
    else
      halt 400, json({ errors: project.errors.full_messages })
    end
  end

  # DELETE /projects/1
  delete '/:id' do
    restricted_to_users!
    project = Project.find(params[:id])

    if project.destroy
      json({ message: "project deleted."})
    else
      halt 400, json({ errors: project.errors.full_messages })
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
