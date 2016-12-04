require_relative 'base'

class SyncController < ApiController
  post '/' do
    restricted_to!(User::ROLE_ADMIN) { |name| User.find_by_name(name) }

    jsonapi({worker: SincronizerWorker.perform_async}, is_collection: false)
  end
end
