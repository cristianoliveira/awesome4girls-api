# frozen_string_literal: true
require_relative 'base'

# Serializer for subsections.
#
class SubsectionSerializer < BaseSerializer
  attributes :title, :description

  has_many :projects, include_links: false
end
