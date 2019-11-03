# -*- coding: utf-8 -*-

from pyspark.sql import SparkSession


def create_spark_session():
#sc = psk.SparkContext("local", "Simple App")
    spark = SparkSession.builder.appName("test").getOrCreate()
            #.config("spark.dynamicAllocation.enabled", 'true')\
            #.config("spark.dynamicAllocation.maxExecutors", '3')\
            #.config("spark.dynamicAllocation.minExecutors", '1')\
            #.config("spark.executor.memory", '6g')\
            #.enableHiveSupport()\
    return spark



def create_spark_session1():
    conf = (SparkConf()
            .setMaster("local")
            .setAppName("anomaly-selection")
            .set("spark.executor.memory", "1g"))

    spark = SparkSession.builder.config(conf = conf).enableHiveSupport().getOrCreate()

    return spark



def create_spark_session2(name, max_executors='3', executor_memory='6g'):
    return(SparkSession\
    .builder\
    .appName(name)\
    .config("spark.dynamicAllocation.enabled", 'true')\
    .config("spark.dynamicAllocation.maxExecutors", max_executors if max_executors is not None else '3')\
    .config("spark.dynamicAllocation.minExecutors", '1')\
    .config('spark.executor.cores', '8')\
    .config('spark.cores.max', '8')\
    .config("spark.executor.memory", executor_memory if executor_memory is not None else '6g')\
    .config("spark.sql.crossJoin.enabled", "true")\
    .config("spark.shuffle.service.enabled", "true")\
    .config("spark.sql.parquet.writeLegacyFormat", "true")\
    .config("spark.sql.sources.partitionOverwriteMode", "dynamic")\
    .enableHiveSupport()\
    .getOrCreate())



