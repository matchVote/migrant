# Migrant

Migrant manages the matchVote PostgreSQL database schema. It is also used with
other MV services as the local development and test database container. This 
removes the need for each service to manage its own local DB copy (and migrations).

## Local development of services

Since the same DB is shared by all services, you must first start it with Migrant 
for local development and testing. The other services will not work without this DB 
container running.

    $ make start

Setup must be run once to initialize the database for dev and test.

    $ make setup

Afterwards, other MV services will be able to connect to the `matchvote_db` 
container and use the `matchvote_dev` and `matchvote_test` databases.

## Deployment

New migrations will need to be run against the production DB before any 
dependent services are deployed.