require_relative 'base'

class SyncController < ApiController
  post '/' do
    restricted_to!(User::ROLE_ADMIN) { |name| User.find_by_name(name) }

    json(worker: SincronizerWorker.perform_async)
  end
end
