docker build -t zx086401/multi-client:latest -t zx086401/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t zx086401/multi-server:latest -t zx086401/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zx086401/multi-worker:latest -t zx086401/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push zx086401/multi-client:latest
docker push zx086401/multi-server:latest
docker push zx086401/multi-worker:latest

docker push zx086401/multi-client:$SHA
docker push zx086401/multi-server:$SHA
docker push zx086401/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=zx086401/multi-server:$SHA
kubectl set image deployments/client-deployment client=zx086401/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=zx086401/multi-worker:$SHA
