# Docker for solidus

* System dependencies

docker and docker-compose

* Build and run

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

* Database creation
In a different tab, run:
```
docker-compose run app rake db:create
```

* Database initialization
Then run:
```
docker-compose run app rake db:migrate
```

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
