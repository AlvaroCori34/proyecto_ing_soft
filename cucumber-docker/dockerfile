FROM ruby:2.6.5-alpine

RUN apk update && apk add build-base nodejs postgresql-dev tzdata patch ruby-dev curl bash git

RUN mkdir /CSD
WORKDIR /CSD

RUN gem install rspec

COPY ./template ./template
WORKDIR /CSD/template
RUN gem install bundler
RUN bundle install
WORKDIR /CSD

#RUN apk add --no-cache bash

EXPOSE 4567

