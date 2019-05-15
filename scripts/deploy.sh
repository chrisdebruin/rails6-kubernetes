kubectl --namespace=staging-env delete job rails6-db-migrate
kubectl apply -f config/k8s
kubectl --namespace=staging-env set image deployment/rails6-deployment rails6=eu.gcr.io/cloud-run-238617/rails6:$REVISION
kubectl --namespace=staging-env set image deployment/rails6-job rails6-job=eu.gcr.io/cloud-run-238617/rails6:$REVISION
