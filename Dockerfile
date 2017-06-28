FROM ruby:alpine

RUN \
  apk update && apk add --update --upgrade \
  tzdata \
  postgresql-dev \
  build-base \
  git \
  nodejs

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install && \
    echo 'gem: --no-document' >> ~/.gemrc

EXPOSE 3000

WORKDIR /app
ADD . /app
