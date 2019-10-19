module Types
  class QueryType < Types::BaseObject
    field :students, StudentType.connection_type, 'Students accessible to the requesting user', null: false

    def students
      context[:current_user].students
    end
  end
end
