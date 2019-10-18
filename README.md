# Being effective with GraphQL on Rails

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

This will create the database, migrate the table structure, and fill it with seed data.
