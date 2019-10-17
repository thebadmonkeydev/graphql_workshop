## Effective GraphQL on Rails

---
### Who am I?

+++
#### Me

+++
#### GraphQL Experience

---
### Topics

- GraphQL Concepts
- Build a Rails API using graphql-ruby
  - Schema Design
  - Resolvers and testing
  - Production Readiness and Deployment

---
#### GraphQL Concepts

A brief discussion of the core concepts in the GraphQL standard

+++
#### API

GraphQL is an API standard like JsonAPI
- Still technically "RESTful"
  - Every GraphQL request is a POST-ed query
- Client-focused
- Introspective

+++
#### Schema

- The entire API is defined by the schema
- Composed of Fields and Types
  - Fields have a type
  - Types are defined by their fields
- Defines your data definition as a graph

+++
#### Fields

- Two types of fields
  - Scalar types
  - Object types

+++
#### Mutations

Mutation are specialized fields that modify ("mutate") the state of our data

---
#### Setup

+++
#### Repo

---
### Schema Design

+++
#### Type System

+++
#### Fields

+++
#### Mutations

+++
#### Schema-level Customizations

---
### Field Resolution

+++
#### Default Behavior

+++
#### Resolver Methods

+++
#### Resolver Classes

---
### Testing

---
### Getting Ready For Production

+++
### Authentication

+++
### Authorization

+++
#### DB Performance

+++
#### Caching

+++
#### Query Parsing
