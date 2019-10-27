#### AHORA ESCRIBIMOS ALGO EN LA RAMA DE DEV
#### AHORA ESCRIBIMOS ALGO EN LA RAMA DE DEV


#import pyspark as psk
from pyspark.sql import SparkSession


#def create_spark_session():
#sc = psk.SparkContext("local", "Simple App")
spark = SparkSession.builder.appName("test").getOrCreate()
        #.config("spark.dynamicAllocation.enabled", 'true')\
        #.config("spark.dynamicAllocation.maxExecutors", '3')\
        #.config("spark.dynamicAllocation.minExecutors", '1')\
        #.config("spark.executor.memory", '6g')\
        #.enableHiveSupport()\
#return spark




rdd1 = spark.sparkContext.textFile('extracto-quijote.txt')

num = rdd1.filter(lambda line: 'un' in line).count()

print(num)
spark.stop()
