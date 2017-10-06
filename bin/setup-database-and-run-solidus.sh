#!/bin/sh

export RAILS_ENV=production
export RAILS_SERVE_STATIC_FILES=true

AUTO_ACCEPT=true bundle exec rake db:create db:migrate db:seed

bundle exec rails server
