# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  first_name :string
#  last_name  :string
#  user_type  :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_accounts_on_user_type_and_user_id  (user_type,user_id)
#

class Account < ApplicationRecord
  belongs_to :user, polymorphic: true
end
