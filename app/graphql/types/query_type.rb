module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :numbers, [Integer], 'A list of ints', null: false
    field :pi, Float, 'Delicious!', null: false

    def numbers
      [ 1, 2, 5 ]
    end

    def pi
      3.1415
    end
  end
end
