FROM mysql:latest
FROM ruby:2.7.3-slim

RUN apt-get update
RUN apt-get install -y build-essential libpq-dev default-mysql-client
RUN apt-get install -y rubygems ruby-mysql2 wget build-essential default-libmysqlclient-dev ruby2*-dev
RUN gem install mysql2
RUN gem install nokogiri --platform=ruby
RUN bundle config set force_ruby_platform true

RUN mkdir api

ADD . /api
WORKDIR /api

RUN gem install bundler
RUN bundle install
RUN bash -c 'rm -f tmp/pids/server.pid'

EXPOSE 3000
CMD ["rails","server","-b","0.0.0.0", "-e", "development"]