module Types
  class MessageType < Types::BaseObject
    description 'A message between a parent and a teacher about a student'

    field :text, String, 'The text content of this message'
    field :created_at, String, 'The date/time this message was sent'
  end
end
