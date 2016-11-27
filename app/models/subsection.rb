# == Schema Information
#
# Table name: subsections
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  section_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Subsection < ActiveRecord::Base
  belongs_to :section
end
