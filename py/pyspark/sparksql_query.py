# -*- coding: utf-8 -*-

from pyspark.sql import SparkSession
from pyspark.sql import HiveContext

spark = SparkSession\
.builder\
.appName("looktobook-ava")\
.config("spark.dynamicAllocation.enabled", 'true')\
.config("spark.dynamicAllocation.maxExecutors", '3')\
.config("spark.dynamicAllocation.minExecutors", '1')\
.config("spark.executor.memory", '6g')\
.enableHiveSupport()\
.getOrCreate()


sql_query = """
SELECT  *				
FROM table_name
WHERE id is not NULL
ORDER BY id, days
limit 10
"""

print('Printing query: ' + sql_query)
spark.sql(sql_query).show()
spark.sql(sql_query).printSchema()