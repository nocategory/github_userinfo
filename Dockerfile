FROM ruby:2.5.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /gh_userinfo
WORKDIR /gh_userinfo
COPY Gemfile /gh_userinfo/Gemfile
COPY Gemfile.lock /gh_userinfo/Gemfile.lock
RUN gem install bundler && bundle install