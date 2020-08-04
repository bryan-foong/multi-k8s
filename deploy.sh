docker build -t bryanfoong/multi-client:latest -t bryanfoong/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bryanfoong/multi-server:latest -t bryanfoong/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bryanfoong/multi-worker:latest -t bryanfoong/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bryanfoong/multi-client:latest 
docker push bryanfoong/multi-server:latest 
docker push bryanfoong/multi-worker:latest

docker push bryanfoong/multi-client:$SHA 
docker push bryanfoong/multi-server:$SHA 
docker push bryanfoong/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bryanfoong/multi-server:$SHA
kubectl set image deployments/client-deployment client=bryanfoong/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bryanfoong/multi-worker:$SHA
