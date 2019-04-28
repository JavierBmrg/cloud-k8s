#!/usr/bin/env bash

docker build -t ewfnz/k8s-client:latest -t ewfnz/k8s-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t ewfnz/k8s-worker:latest -t ewfnz/k8s-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker build -t ewfnz/k8s-server:latest -t ewfnz/k8s-server:$GIT_SHA -f ./server/Dockerfile ./server

docker push ewfnz/k8s-client:latest
docker push ewfnz/k8s-worker:latest
docker push ewfnz/k8s-server:latest
docker push ewfnz/k8s-client:$GIT_SHA
docker push ewfnz/k8s-worker:$GIT_SHA
docker push ewfnz/k8s-server:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ewfnz/k8s-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=ewfnz/k8s-worker:$GIT_SHA
kubectl set image deployments/client-deployment client=ewfnz/k8s-client:$GIT_SHA
