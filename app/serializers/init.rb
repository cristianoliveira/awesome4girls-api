class BaseSerializer
  include JSONAPI::Serializer

  def self_link
    "#{super}"
  end
end

require_relative 'user'
require_relative 'section'
require_relative 'subsection'
require_relative 'project'
