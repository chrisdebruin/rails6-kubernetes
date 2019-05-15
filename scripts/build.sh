#/bin/bash

export CACHE_IMAGE=eu.gcr.io/cloud-run-238617/rails6
export RAILS_ENV=staging

if [[ "${CI}" ]]; then
  # reset database.yml sice semaphore will overwrite it
  git checkout -- config/database.yml
fi

docker pull $CACHE_IMAGE:$BRANCH_NAME || true
docker build --quiet --cache-from $CACHE_IMAGE:$BRANCH_NAME --build-arg RAILS_MASTER_KEY=$(cat config/master.key) --build-arg RAILS_ENV=$RAILS_ENV --build-arg GIT_REVISION=$REVISION --tag $CACHE_IMAGE:$BRANCH_NAME --tag $CACHE_IMAGE:$REVISION .

docker push $CACHE_IMAGE:$BRANCH_NAME | cat
docker push $CACHE_IMAGE:$REVISION | cat
