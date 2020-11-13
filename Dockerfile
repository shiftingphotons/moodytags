FROM ruby:2.6
MAINTAINER dralev@pm.me
# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
#
RUN apt update && apt install -y \ 
  postgresql-client-11

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
WORKDIR /usr/src/app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile* ./

RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the main application.
COPY . .

# TODO: Remove if things are fine
# ENV DB_HOST=db

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000
