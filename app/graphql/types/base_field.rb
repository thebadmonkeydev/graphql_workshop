module Types
  class BaseField < GraphQL::Schema::Field
    argument_class Types::BaseArgument

    def resolve_field(obj, args, ctx)
      resolve(obj, args.to_h, ctx)
    end
  end
end
