FROM ruby:2.7.1

RUN apt-get update -qq && apt-get install -y postgresql-client
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

ENV RAILS_ROOT /var/www/swmoss
ENV RAILS_ENV production
ENV RACK_ENV production
# make a new directory where our project will be copied
RUN mkdir -p $RAILS_ROOT

# Set working directory within container
WORKDIR $RAILS_ROOT
COPY . $RAILS_ROOT

RUN bundle install \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt install -y nodejs

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
RUN bundle exec rake assets:precompile
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
