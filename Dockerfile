FROM ruby:2.6.1

RUN apt-get update -qq && apt-get install -y nodejs mysql-server imagemagick cron redis-server

WORKDIR /app

RUN gem install bundler -v 2.0.2
COPY Gemfile* ./
RUN bundle install

EXPOSE 3000
