# frozen_string_literal: true

class UsersController < Sinatra::Base
  register Sinatra::BasicAuth
  register Sinatra::ErrorsHandler
  helpers Sinatra::Param

  before do
    content_type :json
    authorize!("admin") { |name, pass|
      user = User.find_by_name(name)
      user and user.auth?(pass) and user.is_a?(User::ROLE_ADMIN)
    }
  end

  # GET /users/1
  get '/:id' do
    user = User.find(params[:id])
    json({ type: :user, data: user })
  end

  # GET /users
  get '/' do
    json User.all()
  end

  # POST /users?name=bob&password=123&role=1
  post '/' do
    param :name, String, required: true
    param :password, String, required: true
    param :role, Integer, required: true

    user = User.new(params)

    if user.save
      json({ message: "User created."})
    else
      halt 400, json({ error: user.errors.full_messages })
    end
  end

  # DELETE /users/1
  delete '/:id' do
    user = User.find(params[:id])

    if user.destroy
      json({ message: "User deleted."})
    else
      halt 400, json({ error: user.errors.full_messages })
    end
  end
end
