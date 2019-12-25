FROM ruby:2.6.1

RUN apt-get update -qq && apt-get install -y nodejs mysql-server

RUN mkdir /vaccination_center_management
WORKDIR /vaccination_center_management

RUN gem install bundler -v 2.0.2
COPY Gemfile /vaccination_center_management/Gemfile
RUN bundle install

CMD ["rails", "s", "-b", "0.0.0.0"]
EXPOSE 3000
