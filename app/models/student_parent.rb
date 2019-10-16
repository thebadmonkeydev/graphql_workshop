# == Schema Information
#
# Table name: student_parents
#
#  id         :integer          not null, primary key
#  student_id :integer
#  parent_id  :integer
#

class StudentParent < ApplicationRecord
  belongs_to :student
  belongs_to :parent
end
