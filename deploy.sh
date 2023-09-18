docker build -t kalalbasit/multi-client:latest -t kalalbasit/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kalalbasit/multi-server:latest -t kalalbasit/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kalalbasit/multi-worker:latest -t kalalbasit/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kalalbasit/multi-client:latest
docker push kalalbasit/multi-server:latest
docker push kalalbasit/multi-worker:latest

docker push kalalbasit/multi-client:$SHA
docker push kalalbasit/multi-server:$SHA
docker push kalalbasit/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kalalbasit/multi-server:$SHA
kubectl set image deployments/client-deployment client=kalalbasit/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kalalbasit/multi-worker:$SHA