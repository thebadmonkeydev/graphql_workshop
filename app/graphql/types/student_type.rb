module Types
  class StudentType < Types::BaseObject
    description 'A student to be discussed by parents and teachers'

    field :first_name, String
    field :gpa, Float, 'The GPA of this student on a 4.0 scale'
    field :id, ID, 'Unique Identifier for this student'
    field :last_name, String

    field :teacher, TeacherType, 'The current teacher for this student'
    field :messages, MessageType.connection_type, 'Messages regarding this student'
  end
end
