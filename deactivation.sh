#!/bin/bash

kubectl delete -f deployment-mongo.yaml
kubectl delete -f service-mongo.yaml
kubectl delete -f pvc-mongo.yaml
kubectl delete -f deployment-flask.yaml
kubectl delete -f service-flask.yaml
kubectl delete -f deployment-express.yaml
kubectl delete -f service-express.yaml
kubectl delete -f deployment-kafka.yaml
kubectl delete -f service-kafka.yaml
kubectl delete -f init-kafka.yaml
kubectl delete -f pvc-kafka.yaml
kubectl delete -f deployment-ui.yaml
kubectl delete -f service-ui.yaml
kubectl delete -f spark-entero.yaml
kubectl delete -f pvc-spark.yaml
kubectl delete -f hdfs-entero.yaml
kubectl delete -f pvc-hdfs.yaml