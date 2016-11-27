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
#  author_id     :integer
#


class Project < ActiveRecord::Base
  belongs_to :subsection
  belongs_to :author, class_name: "User"

  validates :title, presence: true
  validates :description, presence: true
  validates :language, length: {
    maximum: 2,
    allow_nil: true,
    message: "Languages must be ISO639-1 code standard. Ex: en, pt"
  }

  def destroy_by(user)
    unless self.author_id == user.id or user.is_a?(User::ROLE_ADMIN)
      errors.add(:not_allowed, 'Cannot delete projects from other author')
      return false
    end
    self.destroy
  end
end
