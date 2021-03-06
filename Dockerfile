FROM ruby:2.6.1-alpine

ENV PATH /root/.yarn/bin:$PATH

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh build-base nodejs tzdata mariadb-dev

RUN apk update \
  && apk add curl bash binutils tar gnupg \
  && rm -rf /var/cache/apk/* \
  && /bin/bash \
  && touch ~/.bashrc \
  && curl -o- -L https://yarnpkg.com/install.sh | bash \
  && apk del curl tar binutils

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
WORKDIR /usr/src/app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install -j 5 --retry 5 --without development test

# Set Rails env
ARG RAILS_ENV
ENV RAILS_ENV $RAILS_ENV
ENV RAILS_ROOT /usr/src/app
# Use Rails for static files in public
ENV RAILS_SERVE_STATIC_FILES 1

# You must pass environment variable RAILS_MASTER_KEY
ARG RAILS_MASTER_KEY
ENV RAILS_LOG_TO_STDOUT 1
ARG GIT_REVISION
ENV GIT_REVISION $GIT_REVISION
# Copy the main application.
COPY . ./

# Precompile Rails assets (plus Webpack)
RUN RAILS_MASTER_KEY=$RAILS_MASTER_KEY bundle exec rake assets:precompile \
  && rm -rf node_modules

# Will run on port 3000 by default
EXPOSE 3000
# Start puma
CMD bundle exec puma -C config/puma.rb
