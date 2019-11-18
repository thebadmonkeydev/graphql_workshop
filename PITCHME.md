## Effective GraphQL on Rails

---
## Who am I?

+++
@snap[centerpoint span-100 text-07]
### GraphQL Experience

- **AssembledBrands (NY)** - Implemented a green-field production GraphQL API supporting a React client
- **Stackshare (SF)** - Migrated from their existing REST API to GraphQL incrementally
- Author/maintainer of the graphql-cache gem
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
@box[bg-purple box-padding rounded](Scalar Types#String, ID, Integer, Float, Boolean, List)
@snapend
@snap[south-east span-30]
@box[bg-purple box-padding rounded](Object Types#User, Account, Connections, Widget, etc.)
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
## Break

---
## Let's do it in Rails

@snap[span-100 font-07]
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

+++
### Defining Arguments

Arguments for a field are defined within a block that's passed during field declaration:

```ruby
field :school, SchoolType, 'Query a specific school', null: true do
  argument :id, ID, 'The unique identifier for a school', required: true
end
```

---
## Field Resolution

To resolve a field in GraphQL we need 3 things:

- Any arguments provided
- The query Context
- A parent object to resolve on

+++
@snap[north span-100 text-bottom]
### Where does graphql-ruby look?
@snapend

@snap[west span-25 font-06]
@box[bg-purple box-padding rounded](1#Method on type)
@snapend
@snap[midpoint span-25 font-06]
@box[bg-purple box-padding rounded](2#Method on `object`)
@snapend
@snap[east span-25 font-06]
@box[bg-purple box-padding rounded](3#Hash Key on `object`)
@snapend

+++
### The resolver method

When defining a method on the type definition, we have access to all the query information:

```ruby
# arguments defined for the field are passed as keyword arguments
def school(id:)
  object  # The parent object being resolved on
  context # the Query context (acts like a hash)

  School.find_by(id: id)
end
```

---
## Mutations

Mutations are a separate entity in graphql-ruby and are defined by inheriting from `Types::MutationType`, defining arguments, result types, and a `resolve` method

Note:

If you look deep in graphql-ruby you'll find that a Mutation is just a subclass of a parent `Resolver` class

---
## Break

---
## Designing our Schema

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
      - Mutations
      - Critical Paths
  - Resolver Unit tests
  - Type structure
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

---
## Advanced Topics

- Schema Stitching
- Server Side Rendering (SSR)

---
## Fin
