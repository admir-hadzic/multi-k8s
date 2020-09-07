docker build -t admirhadzic/multi-client:latest -t admirhadzic/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t admirhadzic/multi-worker:latest -t admirhadzic/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker build -t admirhadzic/multi-server:latest -t admirhadzic/multi-server:$GIT_SHA -f ./server/Dockerfile ./server

docker push admirhadzic/multi-server:latest
docker push admirhadzic/multi-server$GIT_SHA

docker push admirhadzic/multi-client:latest
docker push admirhadzic/multi-client$GIT_SHA

docker push admirhadzic/multi-worker:latest
docker push admirhadzic/multi-worker$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=admirhadzic/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=admirhadzic/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=admirhadzic/multi-worker:$GIT_SHA