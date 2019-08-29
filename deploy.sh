docker build -t babblegrabble/multi-client:latest -t babblegrabble/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t babblegrabble/multi-server:latest -t babblegrabble/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t babblegrabble/multi-worker:latest -t babblegrabble/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push babblegrabble/multi-client:latest
docker push babblegrabble/multi-server:latest
docker push babblegrabble/multi-worker:latest

docker push babblegrabble/multi-client:$SHA
docker push babblegrabble/multi-server:$SHA
docker push babblegrabble/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=babblegrabble/multi-client:$SHA
kubectl set image deployments/server-deployment server=babblegrabble/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=babblegrabble/multi-worker:$SHA
