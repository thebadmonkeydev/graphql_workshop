module Types
  class TeacherType < Types::BaseObject
    description 'A public school teacher'

    field :first_name, String
    field :grade, Integer, 'The grade level taught by this teacher (0-12)'
    field :id, ID, 'The unique identifier for this teacher'
    field :last_name, String
    field :title, String, 'Mr, Ms, Miss'
  end
end
