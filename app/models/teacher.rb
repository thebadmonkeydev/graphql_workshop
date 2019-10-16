# == Schema Information
#
# Table name: teachers
#
#  id         :integer          not null, primary key
#  grade      :integer
#  title      :string
#  school_id  :integer
#  first_name :string
#  last_name  :string
#

class Teacher < ApplicationRecord
  belongs_to :school

  has_many :students
  has_one :account, as: :user
end
