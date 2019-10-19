# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  gpa        :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  teacher_id :integer
#

class Student < ApplicationRecord
  belongs_to :teacher

  has_many :messages
  has_many :student_parents
  has_many :parents, through: :student_parents
end
