FROM cargosense/elixir-ubuntu:21.0-v1.7.3

# Install debian packages
RUN apt-get update
RUN apt-get install -y build-essential inotify-tools postgresql-client

# Install Phoenix packages
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez

RUN mix deps.get
RUN mix deps.compile

WORKDIR /app
EXPOSE 4000
