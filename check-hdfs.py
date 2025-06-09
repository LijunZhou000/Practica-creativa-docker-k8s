from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("ReadLatestParquet").getOrCreate()

# Ruta HDFS donde están los archivos parquet
path = "hdfs://localhost:8020/user/root/flight_delay_ml_response"

# Leer toda la carpeta parquet
df = spark.read.parquet(path)

# Mostrar los datos
df.show()
