# Práctica creativa
> ### Trabajo realizado por Sergio Manrique Lorenzo y Lijun Zhou
## Resumen comandos
Todos los comandos se ejecutan directamente desde la raíz de la práctica, `$ docker-k8s` .

Para usar docker.

* **`docker compose up --build`**

Para Airflow y MLflow hay que entrar a la carpeta `mlflow_airflow` y ejecutar **`docker compose up --build`**

Para usar k8s. Se necesita tener kubernetes y kubectl instalados
[Comandos para la instalación](#instalar-kubernetes-y-kubectl) (Al final del readme)

* **`docker compose down`**
* **`sh start-k8s.sh`** o simplemente `minikube start --cpus=4 --memory=4096
` si no necesita visualizar el dashboard.
* **`sh crear-imagenes.sh`** Para crear las imágenes necesarias si no las tienes.
* **`sh activation.sh`**

Si se está utilizando wsl, no funciona la conexión usando minikube ip, hay que abrir un tunel para poder conectarse a los servicios.

* **`sh tunnel.sh`**
## Enlaces
**Para docker**

Flask : [http://localhost:5001/flights/delays/predict_kafka](http://localhost:5001/flights/delays/predict_kafka)

Mongo express : [http://localhost:8082/](http://localhost:8082/)

Kafka UI : [http://localhost:8083/](http://localhost:8083/)

Spark master : [http://localhost:8086/](http://localhost:8086/)

Nifi : [https://localhost:8443/nifi/](https://localhost:8443/nifi/)

HDFS : [http://localhost:9870/explorer.html#/user/root/flight_delay_ml_response](http://localhost:9870/explorer.html#/user/root/flight_delay_ml_response)

Airflow: [http://localhost:8087/](http://localhost:8087/)

MLflow: [http://localhost:600/](http://localhost:600/)

**Para k8s**, son los mismos puertos pero cambiando localhost por el valor que sale al ejecutar `minikube ip`

## Parte obligatoria

Para esta parte solo hace falta ejecutar el comando **`docker compose up --build`** desde el directorio raíz de la práctica, `$ docker-k8s` . Puede tarda hasta 1 minuto para tener todo corriendo y preparado para realizar las predicciones.

Dentro del `docker-compose.yml` tenemos dockerizado todo lo que se nos pide, incluido nifi. Se ha utilizado un `Dockerfile` personalizado para flask, donde se define una variable de estado y se instalan las dependencias necesarias; y otro para mongo, para copiar los datos automáticamente a la base de datos.

Para acceder a nifi el usuario es admin y la constraseña 098765432100. Usamos solo dos processors, primero `ConsumeKafka_2_0 1.25.0` con la siguiente configuración en properties (Kafka Brokers : kafka:9092, Topic Name(s) : flight-delay-ml-response, Group ID : nifi-kafka), el segundo es `ExecuteStreamCommand 1.25.0` con la configuración en properties (Command path : /usr/bin/bash, Command arguments : -c;"cat >> /output/messages.txt | printf '\n' >> /output/messages.txt"), en scheduling indicamos un run schedule de 10 sec y en la pestaña de relationships marcamos las tres con terminate. Por último conectamos ConsumeKafka con ExecuteStreamCommand para la relationship success.

Antes de desplegar k8s ejecutamos el comando `docker compose down` para dejar libres los puertos para los despliegues con k8s.

## Parte opcional
Para que las predicciones se guardasen en HDFS hemos añadido dos contenedores extras al `docker-compose.yml`

Para entrenar el modelo usando Airflow y MLflow hemos modificado el archivo que se usa para entrenar los modelos en local para que guarde el modelo entrenado dentro de MLflow y hemos desplegado Airflow para orquestar el entrenamiento.

Para el despliegue en k8s ejecutamos primero el comando `sh k8s-start.sh`, después creamos imágenes personalizadas para mongo , spark y flask con `sh crear-imagenes.sh` y por último, el comando `sh activation.sh`

### Instalar kubernetes y kubectl
Primero necesitamos instalar minikube, [Link al tutorial](https://minikube.sigs.k8s.io/docs/start/?arch=/linux/x86-64/stable/debian%20package), en nuestro caso usando ubuntu usamos, `curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
`, `sudo dpkg -i minikube_latest_amd64.deb` y `minikube start --memory=2048 --cpus=2` .

Después, instalamos kubectl, [Link al tutorial](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux), `curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
`, `curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
`, `echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
`, `sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
` y `kubectl version --client
`
