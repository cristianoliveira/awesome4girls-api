# frozen_string_literal: true
require_relative 'base'

# Responsible expose projects endpoints
#
class ProjectsController < ApiController
  # GET /projects/1
  get '/:id' do
    project = Project.find(params[:id])
    jsonapi(project, is_collecion: false)
  end

  # GET projects?subsection=1
  get '/' do
    jsonapi(Project.all, is_collection: true)
  end

  # POST /projects?title=meetup&description=somedescription&lang=pt
  post '/' do
    restricted_to!(User::ROLE_USER) { |name| @user = User.find_by_name(name) }

    param :title, String, required: true
    param :description, String, required: true
    param :subsection, Integer, required: true

    subsection = Subsection.find(params[:subsection])
    project = subsection.projects.new(title: params[:title],
                                      link: params[:link],
                                      description: params[:description],
                                      subsection: subsection,
                                      author_id: @user.id)

    if project.save
      jsonapi(project, is_collecion: false)
    else
      halt 400, jsonapi_errors(project.errors)
    end
  end

  # DELETE /projects/1
  delete '/:id' do
    restricted_to!(User::ROLE_USER) { |name| @user = User.find_by_name(name) }
    project = Project.find(params[:id])

    if project.destroy_by(@user)
      json(message: 'project deleted.')
    else
      status = project.errors.include?(:not_allowed) ? 405 : 400
      halt status, jsonapi_errors(project.errors)
    end
  end
end
