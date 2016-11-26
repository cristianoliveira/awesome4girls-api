# frozen_string_literal: true

module Sinatra
  module BasicAuth
    class AuthenticationError < Exception
    end

    module Helpers
      def authorize!(realm, &block)
        headers "WWW-Authenticate" => %[Basic realm="#{realm}"]
        auth =  Rack::Auth::Basic::Request.new(request.env)

        unless auth.provided? and auth.basic? and auth.credentials
          raise AuthenticationError, "Basic Authentication not provided."
        end

        name, password = auth.credentials

        authorized = block.call(name, password)
        unless authorized
          raise AuthenticationError, "User not authorized."
        end
      end
    end

    def self.registered(app)
      app.helpers BasicAuth::Helpers
    end
  end
end
