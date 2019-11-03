
CREATE DATABASE IF NOT EXISTS name_db;

DROP TABLE IF EXISTS  scheme_hive.hive_table;

CREATE EXTERNAL TABLE  scheme_hive.hive_table(
var1 integer,
var2 varchar(6),
var3 varchar(3),
var4 varchar(3),
var5 date,
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
LOCATION 's3://path/'
;
