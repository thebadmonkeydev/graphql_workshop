# Being effective with GraphQL on Rails

**Presented By**
Michael Kelly
michaelkelly322@gmail.com


_This repo uses gitpitch.com for presenting it's contents.  Please visit https://gitpitch.com/thebadmonkeydev/graphql_workshop to view it in presentation form_

## Getting Setup

**Prerequisites:**
- `Ruby >= 2.6`
- `Rails >= 6`
- A docker daemon running locally with docker-compose available, or a local install of PostgresQL

Clone the graphql_workshop app from Github:

```
git clone https://github.com/thebadmonkeydev/graphql_workshop.git
```

Next, navigate to the new project folder and install the gem bundle

```
cd graphql_workshop
bundle install
```

Make sure you have PostgresQL running locally (either by having it installed natively or through the `docker-compose.yml` file provided with this repo. Then run:

```
bin/rails db:setup
```

This will create the database, migrate the table structure, and fill it with seed data.  The app comes setup with an existing set of models and data that we'll use through the workshop.  Each model has it's database columns in comments at the top it's file (using the [annotations](https://github.com/brentgreeff/annotate) gem) to make understanding this data model a bit easier.

The graphql_workshop application is a Rails API providing functionality for a hypothetical frontend client that allows school teachers and parents to exchange messages about students.
