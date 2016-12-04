class SyncController < ApiController
  post '/' do
    p params
    "worker #{SincronizerWorker.perform_async} "
  end
end
