# Migrant

Migrant manages the matchVote Postgresql database schema. It is also used with
other MV services as the local development and test database container. This 
removes the need for each service to manage its own local DB copy (and migrations).

## Local development of services

Since all services share the same DB, you must first start it with migrant for 
local development and testing. The other services will not work without this DB container running.

    $ docker-compose up -d --scale migrant=0

On initial creation, `setup` must be run for dev and test.

    $ docker-compose run --rm migrant mix ecto.setup
    $ docker-compose run --rm -e MIX_ENV=test migrant mix ecto.setup

Afterwards, other MV services will be able to connect to the `matchvote_db` 
container and use the `matchvote_dev` and `matchvote_test` databases.

## Deployment

New migrations will need to be run against the production DB before any 
dependent services are deployed.