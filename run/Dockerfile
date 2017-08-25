FROM ruby:alpine

RUN \
  apk update && apk add \
  imagemagick

ENV RAILS_ENV development
ENV APP_HOME /home/solidus

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY /artifacts/src .

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
