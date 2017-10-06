#!/bin/sh

export RAILS_ENV=production
export RAILS_SERVE_STATIC_FILES=true

bundle exec rake db:create
bundle exec rake db:migrate

# TODO: we should only call 'rake db:seed' one time. the seeds.rb file does
# it's own check if it's already been seeded, but check should really be here.
AUTO_ACCEPT=true bundle exec rake db:seed

bundle exec rails server
