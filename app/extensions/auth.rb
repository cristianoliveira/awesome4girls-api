# frozen_string_literal: true

module Sinatra
  # Sinatra extencion to implement custo basic auth
  #
  module BasicAuth
    # Represents and Authentication error.
    # It occours when has an attempt to access on restricted endpoint
    # without correct credentials
    #
    class AuthenticationError < RuntimeError
    end

    def restricted_to!(role)
      headers 'WWW-Authenticate' => 'Basic realm=member'

      name, pass = credentials(request)
      user = yield(name)
      authorized = user && user.auth?(pass) && user.is_a?(role)

      raise AuthenticationError, 'User not authorized.' unless authorized
    end

    def credentials(request)
      auth = Rack::Auth::Basic::Request.new(request.env)

      unless auth.provided? && auth.basic? && auth.credentials
        raise AuthenticationError, 'Basic Authentication not provided.'
      end

      auth.credentials
    end
  end
end
