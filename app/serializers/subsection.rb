# frozen_string_literal: true

# Serializer for subsections.
#
class SubsectionSerializer < BaseSerializer
  attributes :title, :description

  has_many :projects

  def self_link
    "#{super}"
  end
end

