FROM ruby:2.6.1

RUN apt-get update -qq && apt-get install -y nodejs mysql-server imagemagick cron redis-server
WORKDIR /app

RUN gem install bundler -v 2.0.2
COPY Gemfile* ./
RUN bundle install
COPY . /app

EXPOSE 3000
RUN bundle exec wheneverize .
RUN bundle exec whenever --update-crontab --set environment=development && service cron start
