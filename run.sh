#!/bin/sh
# Adapted from Alex Kleissner's post, Running a Phoenix 1.3 project with docker-compose
# https://medium.com/@hex337/running-a-phoenix-1-3-project-with-docker-compose-d82ab55e43cf

set -e

# Ensure the app's dependencies are installed
mix deps.get

# Install JS libraries
cd assets && npm install
npm rebuild node-sass
cd ..

# Wait for Postgres to become available.
# until psql -h db -U "postgres" -c '\q' 2>/dev/null; do
#   echo >&2 "Postgres is unavailable - sleeping"
#   sleep 1
# done

echo "\nPostgres is available: continuing with database setup..."

# Potentially Set up the database
mix ecto.create --quiet
mix ecto.migrate --quiet

# Start the phoenix web server
mix phx.server
