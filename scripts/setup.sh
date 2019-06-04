kubectl config set-context --current --namespace=staging-env

kubectl create secret generic rails-secrets --from-literal master-key=$(cat config/master.key)
kubectl create secret tls flexcoder-secret --key certbot/live/k8s.flexcoder.nl/privkey.pem --cert certbot/live/k8s.flexcoder.nl/cert.pem

kubectl apply -f config/k8s/
