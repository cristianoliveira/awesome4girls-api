# frozen_string_literal: true

module Sinatra
  # Sinatra extencion to implement custo basic auth
  #
  module JsonApi
    # Helpers for responding json in JsonApi format
    #
    module Helpers
      # Method for rendering models.
      #
      # == Parameters:
      # data::
      #   Model object. It MUST to have an serializer object.
      # options::
      #   Optional params for serializing
      #
      def jsonapi(data, options={})
        json JSONAPI::Serializer.serialize(data, options)
      end

      # Method for rendering errors.
      #
      # == Parameters:
      # errors::
      #   ActiveRecord errors
      #
      def jsonapi_errors(errors)
        json JSONAPI::Serializer.serialize_errors(errors)
      end
    end

    def self.registered(app)
      app.helpers JsonApi::Helpers
    end
  end
end
