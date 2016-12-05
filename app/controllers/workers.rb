# frozen_string_literal: true
class WorkersController <  Sidekiq::Web
  def initialize
    self.use(Rack::Auth::Basic) do |name, password|
      user = User.find_by_name(name)
      user and user.auth?(password) and user.is_a?(User::ROLE_ADMIN)
    end
  end
end
