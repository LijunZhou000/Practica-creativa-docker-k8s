#!/bin/bash

kubectl apply -f practica-creativa.yaml
kubectl apply -f pvc-mongo.yaml
kubectl apply -f deployment-mongo.yaml
kubectl apply -f service-mongo.yaml
kubectl apply -f deployment-flask.yaml
kubectl apply -f service-flask.yaml
kubectl apply -f deployment-express.yaml
kubectl apply -f service-express.yaml
kubectl apply -f pvc-kafka.yaml
kubectl apply -f deployment-kafka.yaml
kubectl apply -f service-kafka.yaml
kubectl apply -f init-kafka.yaml
kubectl apply -f deployment-ui.yaml
kubectl apply -f service-ui.yaml
kubectl apply -f pvc-spark.yaml
kubectl apply -f spark-entero.yaml
kubectl apply -f pvc-hdfs.yaml
kubectl apply -f hdfs-entero.yaml