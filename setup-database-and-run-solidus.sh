#!/bin/sh

bundle exec rake db:create
bundle exec rake db:migrate
echo "no" | AUTO_ACCEPT=true bundle exec rake db:seed

bundle exec rails server
