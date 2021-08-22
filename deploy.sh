docker build -t santoshbs/multi-client:latest -t santoshbs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t santoshbs/multi-server:latest -t santoshbs/multi-server:$SHA -f ./server/Dockerfile ./server
dokcer build -t santoshbs/mutli-worker:latest -t santoshbs/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push santoshbs/multi-client:latest
docker push santoshbs/multi-server:latest
docekr push santoshbs/multi-worker:latest

docker push santoshbs/multi-client:$SHA
docker push santoshbs/multi-server:$SHA
docker push santoshbs/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=santoshbs/multi-server:$SHA
kubectl set image deployments/client-deployment client=santoshbs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=santoshbs/multi-worker:$SHA
