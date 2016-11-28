# frozen_string_literal: true

# Base serializer
#
class BaseSerializer
  include JSONAPI::Serializer

  def self_link
    super.to_s
  end
end

require_relative 'user'
require_relative 'section'
require_relative 'subsection'
require_relative 'project'
