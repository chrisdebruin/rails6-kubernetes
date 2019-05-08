#/bin/bash

export CACHE_IMAGE=chrisdebruin/rails6
export RAILS_ENV=staging

docker pull $CACHE_IMAGE:$BRANCH_NAME || true
docker build --cache-from $CACHE_IMAGE:$BRANCH_NAME --build-arg RAILS_MASTER_KEY=$(cat config/master.key) --build-arg RAILS_ENV=$RAILS_ENV --build-arg GIT_REVISION=$REVISION --tag $CACHE_IMAGE:$BRANCH_NAME .

docker push $CACHE_IMAGE:$BRANCH_NAME
