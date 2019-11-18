module Mutations
  class CreateMessage < GraphQL::Schema::Mutation
    description 'Creates a new message about a student'

    argument :student_id, ID, 'The student this message is about', required: true
    argument :text, String, 'The content of this message', required: true

    field :message, Types::MessageType, 'The newly created message', null: true

    def resolve(student_id:, text:)
      student = context[:current_user].students.find_by(id: student_id)
      return unless student

      message = Message.create!(
        student: student,
        sender: context[:current_user],
        text: text
      )

      {
        message: message
      }
    end
  end
end
