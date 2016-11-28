# frozen_string_literal: true

# Serializer for subsections.
#
class SubsectionSerializer < BaseSerializer
  attributes :title, :description

  def self_link
    "#{super}"
  end
end

