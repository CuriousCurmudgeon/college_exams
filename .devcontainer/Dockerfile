FROM ruby:2.5.8

# Install sqlite3
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends sqlite3

# Install Rails
RUN gem install rails