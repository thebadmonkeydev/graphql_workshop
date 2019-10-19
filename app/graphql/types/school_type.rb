module Types
  class SchoolType < Types::BaseObject
    description 'A public school in the district'

    field :id, ID, 'The unique identifier for this school', null: false
    field :name, String, 'The official name of this school', null: false
  end
end
