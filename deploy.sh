docker build -t kesyyyy/multi-client:latest -t kesyyyy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kesyyyy/multi-server:latest -t kesyyyy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kesyyyy/multi-worker:latest -t kesyyyy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kesyyyy/multi-client:latest
docker push kesyyyy/multi-server:latest
docker push kesyyyy/multi-worker:latest

docker push kesyyyy/multi-client:$SHA
docker push kesyyyy/multi-server:$SHA
docker push kesyyyy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kesyyyy/multi-server:$SHA
kubectl set image deployments/client-deployment client=kesyyyy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kesyyyy/multi-worker:$SHA