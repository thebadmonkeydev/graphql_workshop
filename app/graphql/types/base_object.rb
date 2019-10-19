module Types
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField

    # Syntax sugar so we don't have to type `null: true` all the time
    #
    # def self.field(*args, **kwargs, &block)
    #   kwargs[:null] = true if kwargs[:null].nil? && kwargs[:mutation].nil?
    #   super
    # end
  end
end
