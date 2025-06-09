#!/bin/bash

eval $(minikube docker-env)

docker build -t spark-app-v2 -f Dockerfile.spark .
docker build -t mongo-app -f Dockerfile.mongo .
docker build -t flask-app -f Dockerfile.flask .
