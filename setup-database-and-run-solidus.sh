#!/bin/sh

bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rake spree_sample:load

bundle exec rails server
