#/bin/bash

docker build --build-arg RAILS_MASTER_KEY=$(cat config/master.key) -t rails6 .
docker tag rails6:latest chrisdebruin/rails6
docker push chrisdebruin/rails6
