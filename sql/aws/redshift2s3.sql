unload ('select * from redshift_table_name')
to 's3://path_s3/name-table/'
CREDENTIALS
'aws_access_key_id=****;aws_secret_access_key=****'
delimiter '|'
ALLOWOVERWRITE;






