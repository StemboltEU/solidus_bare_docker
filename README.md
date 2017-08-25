# Docker for solidus

* System dependencies

docker and docker-compose

## Build and run locally

Navigate to home directory and run
```
docker-compose up
```
(using -d flag will run containers in the background)

This should build the images (database and app) from scratch and start the containers.

Examples of how to find IP of your docker container(http://networkstatic.net/10-examples-of-how-to-get-docker-container-ip-address/)

* Re-build

First stop the container (either ctrl-C or docker-compose down), remove and re-build:
```
docker-compose rm && docker-compose build --no-cache && docker-compose up
```

The --no-cache is definitely optional (because it takes forever), but sometimes helpful if you really want the image to build from scratch. (You also have to recreate and initialize the database)

### Database creation & initialization & sample/seed data

To create the database:
```
docker-compose run app rake db:create
```

To initialize the database:
```
docker-compose run app rake db:migrate
```

To seed the database:
```
docker-compose run app rake db:seed
```

To load sample data:
```
docker-compose run app rake spree_sample:load
```

## Environment variables
There are two options. Can either load variables from a local file (env.list) or write them in the command line.

* With a file
Make a local file called 'env.list' in your directory and specify variables
```
mv env.list.sample env.list
```

Then run command (after build):
```
docker run --env-file env-list solidus_bare_docker rails s
```

* In command line
docker run -e ENV_RAILS=production \
  -e RAILS_MAX_THREADS=5 \
  -e SECRET_KEY_BASE=secret_key_base \
  -e DATABASE_URL=postgres://solidus_bare_docker:mypass@localhost/solidus_bare_docker_production \
  solidus_bare_docker rails s


* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Split build/run images
```
$ docker build -t build-solidus build/
$ docker run --rm \
    --volume="$PWD/build/src:/src" \
    --volume="$PWD/run/artifacts:/artifacts" \
    build-solidus
$ docker build -t solidus run/
```
