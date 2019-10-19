## Effective GraphQL on Rails

---
## Who am I?

+++
@snap[centerpoint span-100 text-07]
### GraphQL Experience

- **AssembledBrands (NY)** - Implemented a green-field production GraphQL API supporting a React client
- **Stackshare (SF)** - Migrated from their existing REST API to GraphQL incrementally
- Author of the graphql-cache gem
- Invited to speak at RailsConf Malaysia about implementing GraphQL in Rails
@snapend

---
## Topics

- GraphQL Concepts
- How they manifest in Ruby
- Design and implement a Rails GraphQL API

---
## GraphQL Concepts

A brief discussion of the core concepts in the GraphQL standard

+++
### What is it?

GraphQL is an API standard like JsonAPI or SOAP
- Still technically "RESTful"
  - Every GraphQL request is a POST-ed query
- Client-focused
- Introspective

+++
### Why Use GraphQL?

- Stronger API view-layer abstraction
- Statically typed and client-driven
- Client-driven and type-first paradigms encourage coherent API design

+++
### Controversial Opinion
- Regular REST APIs at scale start to become something similar to GraphQL eventually

+++
### Why NOT Use GraphQL?

- GraphQL is a complex tool, sometimes you need a piece of sandpaper, not a milling machine
- Switching cost can be large for complex data graphs
- Wide-spread client support isn't all there yet

+++
### Schema

- The entire API is defined by the schema
- Composed of Fields and Types
  - Fields have a type
  - Types are defined by their fields
- Defines your data definition as a graph

+++
@snap[north span-100]
### Fields

The fields defined in a GraphQL schema represent the data in our API and are broken up into 2 different types
@snapend

@snap[south-west span-30]
@box[bg-pink box-padding rounded](Scalar Types#String, ID, Integer, Float, Boolean, List)
@snapend
@snap[south-east span-30]
@box[bg-pink box-padding rounded](Object Types#User, Account, Connections, Widget, etc.)
@snapend

+++
### Selecting Fields

The data to be returned from a request is "selected" by the client in the query string:

```json
{
  "query": "{
    scalar_field
    object_field {
      object_type_field
    }
  }"
}
```

+++
### Field Arguments

Fields can take arguments as a means to specify certain resolution behavior.  One common use case is for specifying how many results to return from a list or connection

```json
{
  "query": "{
    students(first: 3) {
      name
    }
  }
}
```

+++
### Mutations

Mutation are specialized fields that modify ("mutate") the state of our data. They take arguments from the query string and return some kind of result.

+++
### Executing Mutations

```json
{
  "query": "mutation {
    updateUser(name: \"Michael\") {
      id
      name
      email
    }
  }"
}
```

---
## Let's do it in Rails

https://github.com/thebadmonkeydev/graphql_workshop
@snapend

- Setup instructions are in README.md
- Once setup, run the server with `bin/run`
- Navigate to http://localhost:3000/graphiql

Note:

Take this opportunity to query the field in GraphiQL

---
## The Schema

```ruby
# app/graphql/graphql_workshop_schema.rb

class GraphqlWorkshopSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
```

+++
### Fields

Root level fields are defined in `app/graphql/types/query_type.rb`

```ruby
module Types
  class QueryType < Types::BaseObject
    field :numbers, [Integer], 'A list of ints', null: false
    field :pi, Float, 'Delicious!'

    def numbers
      [ 1, 2, 5 ]
    end

    def pi
      3.1415
    end
  end
end
```
Note:

Take this opportunity to query the field in GraphiQL

```ruby
module Types
  class QueryType < Types::BaseObject
    field :numbers, [Integer], 'A list of ints', null: false
    field :pi, Float, 'Delicious!'

    def numbers
      [ 1, 2, 5 ]
    end

    def pi
      3.1415
    end
  end
end
```

Note:

- graphql-ruby provides a solid base
  - Scalars
  - Connections (Relay)
- Defining a custom object type

+++
### Defining Custom Types

Custom object types inherit from `Types::BaseObject` which was created during the gem installation

```ruby
# app/graphql/types/school_type.rb

module Types
  class SchoolType < Types::BaseObject
    description 'A public school in the district'

    field :id, ID, 'The unique identifier for this school', null: false
    field :name, String, 'The official name of this school', null: false
  end
end
```

+++
### Referencing Custom Types

```ruby
# app/graphql/types/query_type.rb

# ...

field :school, SchoolType, 'The last school', null: false

def school
  School.last
end
```

---
## Field Resolution

To resolve a field in GraphQL we need 3 pieces of information:

- Field Arguments
- Query Context
- Parent Object to resolve on

+++
### Where does graphql-ruby look?

@snap[south-west span-25 font-06]
@box[bg-pink box-padding rounded](Method on type)
@snapend
@snap[south span-25 font-06]
@box[bg-pink box-padding rounded](Method on `object`)
@snapend
@snap[south-east span-25 font-06]
@box[bg-pink box-padding rounded](Hash Key on `object`)
@snapend

+++

```ruby
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

      { message: message }
    end
  end
end
```

Note:

If you look deep in graphql-ruby you'll find that a Mutation is just a subclass of a Resolver class

---
## Break

---
## Designing our Schema

Note:

Move to live code on `complete-schema` branch

Build schema with class

---
## Break

---
## Schema-level Customizations

- Type inference
- Connection edge fields like count
- Relay Integration (Node Identification)

---
## Break

---
## Mutations

Mutations are a specialized form of field that is used to modify data behind the API.  In a REASTful sense this would encompass the usual POST, PUT, and UPDATE requests.

---
## Schema-level Customizations

- Connection edge fields like count
- Relay Integration (Node Identification)
- Base Types
- Base Classes

---
## Testing

- Best practices
  - Integration/Feature specs
  - Resolver Unit tests
- Examples of using the graphql-ruby lib API to test directly

---
## Concerns for Production

+++
## Authentication

Authentication is usually handled at the controller level through either a token-based API authentication protocol, or some kind of session.

+++
## Authorization

- Hand made
- Ruby gems
- GraphQL Ruby Pro

+++
### DB Performance

- The dreadful n+1
- preloading
- selecting

+++
### Caching

- Manually
- or with `graphql-cache`

+++
### Query Parsing

By default this is done in Ruby. `libgraphqlparser` is a C implementation of the query parser that can be used by graphql-ruby.  It is significantly faster at parsing queries than the built-in ruby parser.

---
## Advanced Topics

- Schema Stitching
- SSR

---
## Fin
