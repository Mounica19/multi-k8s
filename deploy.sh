docker build -t mounica19/multi-client:latest -t mounica19/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mounica19/multi-server:latest -t mounica19/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mounica19/multi-worker:latest -t mounica19/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mounica19/multi-client:latest
docker push mounica19/multi-server:latest
docker push mounica19/multi-worker:latest

docker push mounica19/multi-client:$SHA
docker push mounica19/multi-server:$SHA
docker push mounica19/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mounica19/multi-server:$SHA
kubectl set image deployments/client-deployment client=mounica19/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mounica19/multi-worker:$SHA