# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  text        :text
#  student_id  :integer
#  sender_type :string
#  sender_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_messages_on_sender_type_and_sender_id  (sender_type,sender_id)
#

class Message < ApplicationRecord
  belongs_to :sender, polymorphic: true
  belongs_to :student
end
