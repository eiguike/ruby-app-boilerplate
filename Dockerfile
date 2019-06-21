FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /ruby-app

COPY Gemfile /ruby-app/Gemfile
COPY Gemfile.lock /ruby-app/Gemfile.lock

RUN bundle install

EXPOSE 4567

COPY . /ruby-app

CMD [ "ruby", "main.rb" ]
