FROM ruby:2.3.1

MAINTAINER Pedro Rodrigues "pir.pedro@gmail.com"

RUN apt-get -y update && apt-get install -y \
    python-software-properties \
    build-essential \
    git \
    nodejs \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Use en_US.UTF-8 as our locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc

RUN mkdir -p /app
RUN mkdir -p /root/.ssh/
WORKDIR /app

RUN ssh-keyscan -H github.com >> ~/.ssh/known_hosts
RUN ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts

COPY Gemfile Gemfile.lock ./


ENV GEM_HOME /bundle
ENV PATH $GEM_HOME/bin:$PATH

RUN gem install mailcatcher
RUN gem install bundler -v '1.14.4' \
    && bundle config --global path "$GEM_HOME" \
    && bundle config --global bin "$GEM_HOME/bin"

RUN bundle install --jobs 20 --retry 5

# Copy the main application.
#COPY . ./

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]
