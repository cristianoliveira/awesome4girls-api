# == Schema Information
#
# Table name: projects
#
#  id            :integer          not null, primary key
#  title         :string
#  description   :string
#  language      :string
#  subsection_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Project < ActiveRecord::Base
  belongs_to :subsection

  validates :title, presence: true
  validates :description, presence: true
  validates :language, length: {
    maximum: 2,
    allow_nil: true,
    message: "Languages must be ISO639-1 code standard. Ex: en, pt"
  }
end
