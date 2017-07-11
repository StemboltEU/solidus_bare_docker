FROM ruby:alpine

RUN \
  apk update && apk add --update --upgrade \
  tzdata \
  postgresql-dev \
  build-base \
  git \
  nodejs

ENV BUNDLE_PATH /bundle

COPY Gemfile* ./
RUN bundle install && \
    echo 'gem: --no-document' >> ~/.gemrc

EXPOSE 3000

WORKDIR /app
ADD . /app
