#!/bin/sh

export RAILS_ENV=production
export RAILS_SERVE_STATIC_FILES=true

bundle exec rake db:create
bundle exec rake db:migrate
echo "no" | AUTO_ACCEPT=true bundle exec rake db:seed
bundle exec rake assets:precompile

bundle exec rails server
