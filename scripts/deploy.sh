kubectl --namespace=staging-env delete job rails6-db-migrate
kubectl apply -f config/k8s
kubectl --namespace=staging-env set image deployment/rails6-deployment rails6=chrisdebruin/rails6:$REVISION
