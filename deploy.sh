docker build -t phuongphh/multi-client:latest -t phuongphh/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t phuongphh/multi-server:latest -t phuongphh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t phuongphh/multi-worker:latest -t phuongphh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push phuongphh/multi-client:latest
docker push phuongphh/multi-server:latest
docker push phuongphh/multi-worker:latest

docker push phuongphh/multi-client:$SHA
docker push phuongphh/multi-server:$SHA
docker push phuongphh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=phuongphh/multi-server:$SHA
kubectl set image deployments/client-deployment client=phuongphh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=phuongphh/multi-worker:$SHA
