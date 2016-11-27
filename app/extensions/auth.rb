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

    # Injects authentication helpers methods.
    #
    module Helpers
      def authorize!(realm)
        headers 'WWW-Authenticate' => %(Basic realm="#{realm}")
        auth =  Rack::Auth::Basic::Request.new(request.env)

        unless auth.provided? && auth.basic? && auth.credentials
          raise AuthenticationError, 'Basic Authentication not provided.'
        end

        name, password = auth.credentials

        authorized = yield(name, password)
        raise AuthenticationError, 'User not authorized.' unless authorized
      end
    end

    def self.registered(app)
      app.helpers BasicAuth::Helpers
    end
  end
end
