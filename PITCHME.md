## Effective GraphQL on Rails

---
## Who am I?

+++
### GraphQL Experience

- AssembledBrands (NY) - Implemented a green-field production GraphQL API supporting a React client
- Stackshare (SF) - Migrated from their existing REST API to GraphQL incrementally
- Invited to speak at RailsConf Malaysia about implementing GraphQL in Rails
- Author of the graphql-cache gem

---
## Topics

- GraphQL Concepts
- Build a Rails API using graphql-ruby
  - Schema Design
  - Resolvers and testing
  - Production Readiness and Deployment

---
## GraphQL Concepts

A brief discussion of the core concepts in the GraphQL standard

+++
### API

GraphQL is an API standard like JsonAPI
- Still technically "RESTful"
  - Every GraphQL request is a POST-ed query
- Client-focused
- Introspective

+++
### Why Use GraphQL?

- Stronger API view-layer abstraction
- Client-driven encourages coherent API design
- non-structured REST becomes GraphQL eventually

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
### Fields

- Two types of fields
  - Scalar types
  - Object types

+++
### Mutations

Mutation are specialized fields that modify ("mutate") the state of our data

+++
### Making Requests

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

---
## Break

---
## Let's do it in Rails

+++
### Repo

https://github.com/thebadmonkeydev/graphql_workshop

_Setup instructions are in README.md_

---
## Schema Design

- The schema file

+++
### Fields

- Defining a field
  - Inline
  - Block format
- Arguments
- Best practices

+++
### Type System

- graphql-ruby provides a solid base
  - Scalars
  - Connections (Relay)
- Defining a custom object type

+++
### Mutations

Mutations are a specialized form of field that is used to modify data behind the API.  In a REASTful sense this would encompass the usual POST, PUT, and UPDATE requests.

+++
### Schema-level Customizations

- Connection edge fields like count
- Relay Integration (Node Identification)
- Base Types
- Base Classes

---
## Field Resolution

- Root object
- Arguments, Parent Object, Context
- Resolution Flow
  - Default resolution
  - Resolver methods
  - Resolver Classes

+++
### Default Behavior

The field's name is used to lookup a method by that name, or resolve a hash key with a value of the field's name

+++
### Resolver Methods

A method with the same name as the field is looked up on the type definition, if it exists it is used to resolve the field

+++
### Resolver Classes

Slightly more decoupled way of defining resolver behavior

---
## Testing

- Best practices
  - Integration/Feature specs
  - Resolver Unit tests
- Examples of using the graphql-ruby lib API to test directly

---
## Getting Ready For Production

+++
## Authentication

Authentication is usually handled at the controller level through either a token-based API authentication protocol, or some kind of session.

+++
## Authorization

- Hand made
- gems
- GraphQL Ruby Pro

+++
### DB Performance

- n+1
- preloading
- selecting

+++
### Caching

+++
### Query Parsing

By default this is done in Ruby. `libgraphqlparser` is a C implementation of the query parser that can be used by graphql-ruby.  It is significantly faster at parsing queries than the built-in ruby parser.

---
## Advanced Topics

- Schema Stitching
- SSR

---
## Fin
