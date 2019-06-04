kubectl --namespace=staging-env delete job db-migrate
kubectl apply -f config/k8s/jobs.yml
kubectl --namespace=staging-env set image deployment/web-deployment web=eu.gcr.io/cloud-run-238617/rails6:$REVISION
kubectl --namespace=staging-env set image deployment/job-deployment delayed-job=eu.gcr.io/cloud-run-238617/rails6:$REVISION
