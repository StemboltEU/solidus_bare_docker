FROM ruby:alpine

RUN \
  apk update && apk add --update --upgrade \
  tzdata \
  imagemagick \
  file \
  postgresql-dev \
  build-base \
  git \
  nodejs

ENV BUNDLE_PATH /bundle

COPY Gemfile* ./
RUN bundle install && \
    echo 'gem: --no-document' >> ~/.gemrc

ENV APP_HOME /home/solidus

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD . .

EXPOSE 3000
