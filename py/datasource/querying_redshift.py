# -*- coding: utf-8 -*-

import psycopg2
import pandas as pd

####
#### ...read data from redshift...
con = psycopg2.connect(dbname= ''
                       , host=''
                       , port= ''
                       , user= ''
                       , password= '')
#cur = con.cursor()
#cur.execute("SELECT * FROM trash.sergioc_bag_profile;")
#data = np.array(cur.fetchall())

result = pd.read_sql_query("SELECT * FROM table_name;", con)

#cur.close()
con.close()

####
#### ...write to csv...
#result.to_csv('../../data/one.csv', index = False)
        


    
 
