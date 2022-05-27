docker build -t honzirek/multi-client:latest -t honzirek/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t honzirek/multi-server:latest -t honzirek/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t honzirek/multi-worker:latest -t honzirek/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push honzirek/multi-client:latest
docker push honzirek/multi-client:$SHA
docker push honzirek/multi-server:latest
docker push honzirek/multi-server:$SHA
docker push honzirek/multi-worker:latest
docker push honzirek/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=honzirek/multi-server:$SHA
kubectl set image deployments/client-deployment client=honzirek/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=honzirek/multi-worker:$SHA
