FROM ruby:2.6.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /ruby-app
WORKDIR /ruby-app
COPY Gemfile /ruby-app/Gemfile
COPY Gemfile.lock /ruby-app/Gemfile.lock
RUN bundle install
COPY . /ruby-app
