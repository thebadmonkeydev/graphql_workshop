class Parent < ApplicationRecord
  has_one :account, as: :user
end
