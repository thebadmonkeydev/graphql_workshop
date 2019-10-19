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
### Mutations

Mutation are specialized fields that modify ("mutate") the state of our data. They take arguments from the query string and return some kind of result.

_generally they return the updated object, but there are several approaches to this_

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
