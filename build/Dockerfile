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

VOLUME /src
VOLUME /artifacts

ENV BUNDLE_PATH /bundle

COPY src/Gemfile* /artifacts
RUN bundle install && \
    echo 'gem: --no-document' >> ~/.gemrc

CMD ["cp", "-r", "src", "/artifacts"]
