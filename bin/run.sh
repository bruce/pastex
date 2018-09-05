#!/bin/sh
# Adapted from Alex Kleissner's post, Running a Phoenix 1.3 project with docker-compose
# https://medium.com/@hex337/running-a-phoenix-1-3-project-with-docker-compose-d82ab55e43cf

set -e

# Ensure the app's dependencies are installed
mix deps.get

# Prepare Dialyzer if the project has Dialyxer set up
if mix help dialyzer >/dev/null 2>&1
then
  echo "\nFound Dialyxer: Setting up PLT..."
  mix do deps.compile, dialyzer --plt
else
  echo "\nNo Dialyxer config: Skipping setup..."
fi

# Wait for Postgres to become available.
until pg_isready -h $POSTGRES_HOST -U $POSTGRES_USER; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

echo "\nPostgres is available: continuing with database setup...."

if psql -h $POSTGRES_HOST -U $POSTGRES_USER -c '\q' pastex_dev 2>/dev/null;
then
  echo "Database already setup updating seeds..."
  mix run priv/repo/seeds.exs
else
  mix ecto.reset
fi

echo "\n Launching Phoenix web server..."
# Start the phoenix web server
mix phx.server
