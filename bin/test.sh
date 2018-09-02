#!/bin/sh
# Adapted from Alex Kleissner's post, Running a Phoenix 1.3 project with docker-compose
# https://medium.com/@hex337/running-a-phoenix-1-3-project-with-docker-compose-d82ab55e43cf

set -e

# Ensure the app's dependencies are installed
mix deps.get

# Wait for Postgres to become available.
until pg_isready -h $POSTGRES_HOST -U $POSTGRES_USER; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

echo "\nPostgres is available: continuing with database setup..."

env MIX_ENV=test mix ecto.reset

echo "\n Running tests..."
# Start the phoenix web server
mix test
