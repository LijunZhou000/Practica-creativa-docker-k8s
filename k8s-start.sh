#!/bin/bash

minikube start --memory=2048 --cpus=2
eval $(minikube docker-env)
minikube addons enable metrics-server
minikube dashboard &