# == Schema Information
#
# Table name: parents
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Parent < ApplicationRecord
  has_one :account, as: :user

  has_many :student_parents
  has_many :students, through: :student_parents
end
