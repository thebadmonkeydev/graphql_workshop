class Teacher < ApplicationRecord
  belongs_to :school
  has_one :account, as: :user
end
