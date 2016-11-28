# frozen_string_literal: true

# Serializer for section.
#
class SectionSerializer < BaseSerializer
  attributes :title, :description

  has_many :subsections
end
